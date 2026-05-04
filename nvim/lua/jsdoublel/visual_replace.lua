-- visual replace remaps
do
  local mini_operators = require('mini.operators')
  local eval_transform_key = '_mini_eval_transform'

  mini_operators.setup({
    -- Don't create default keymaps; we'll bind our own.
    evaluate = {
      prefix = '',
      func = function(content)
        local transform = vim.b[eval_transform_key]
        if transform ~= nil then
          return transform(content)
        end
        return mini_operators.default_evaluate_func(content)
      end,
    },
    exchange = { prefix = 'gX' },
    replace = { prefix = '' },
  })

  local function run_visual_eval(transform)
    local previous = vim.b[eval_transform_key]
    vim.b[eval_transform_key] = transform

    local ok, err = xpcall(function()
      mini_operators.evaluate('visual')
    end, debug.traceback)

    vim.b[eval_transform_key] = previous
    if not ok then
      error(err)
    end
  end

  local function wrap_transform(left, right)
    return function(content)
      local text = table.concat(content.lines, '\n')
      if text == '' then
        return content.lines
      end

      local leading = text:match('^%s*') or ''
      local trailing = text:match('%s*$') or ''
      local core = text:sub(#leading + 1, #text - #trailing)
      if core == '' then
        return content.lines
      end

      local wrapped = leading .. left .. core .. right .. trailing
      return vim.split(wrapped, '\n', { plain = true })
    end
  end

  local function make_wrap_mapping(lhs, left, right, desc)
    vim.keymap.set('x', lhs, function()
      run_visual_eval(wrap_transform(left, right))
    end, { desc = desc })
  end

  local function format_outermost_commas(text)
    local open_to_close = { ['('] = ')', ['{'] = '}', ['['] = ']' }
    local close_to_open = { [')'] = '(', ['}'] = '{', [']'] = '[' }

    local first_open_pos, first_open_char
    for idx = 1, #text do
      local ch = text:sub(idx, idx)
      if open_to_close[ch] ~= nil then
        first_open_pos = idx
        first_open_char = ch
        break
      end
    end

    if first_open_pos == nil then
      return text
    end

    local stack = { open_to_close[first_open_char] }
    local close_pos
    for idx = first_open_pos + 1, #text do
      local ch = text:sub(idx, idx)
      local next_open = open_to_close[ch]
      if next_open ~= nil then
        table.insert(stack, next_open)
      elseif close_to_open[ch] ~= nil then
        if stack[#stack] ~= ch then
          return text
        end
        table.remove(stack)
        if #stack == 0 then
          close_pos = idx
          break
        end
      end
    end

    if close_pos == nil then
      return text
    end

    local before = text:sub(1, first_open_pos)
    local inner = text:sub(first_open_pos + 1, close_pos - 1)
    inner = (inner:match('^%s*(.-)%s*$')) or ''
    local after = text:sub(close_pos + 1)
    local current_line = before:match('([^\n]*)$') or before
    local indent = current_line:match('^([ \t]*)') or ''
    local inner_indent = indent .. '  '

    local depth_stack = {}
    local pieces = {}
    local idx = 1
    while idx <= #inner do
      local ch = inner:sub(idx, idx)
      local next_open = open_to_close[ch]
      if next_open ~= nil then
        table.insert(depth_stack, next_open)
        table.insert(pieces, ch)
        idx = idx + 1
      elseif close_to_open[ch] ~= nil then
        if #depth_stack > 0 then
          table.remove(depth_stack)
        end
        table.insert(pieces, ch)
        idx = idx + 1
      elseif ch == ',' and #depth_stack == 0 then
        table.insert(pieces, ',\n' .. inner_indent)
        idx = idx + 1
        while idx <= #inner do
          local lookahead = inner:sub(idx, idx)
          if lookahead:match('%s') then
            idx = idx + 1
          else
            break
          end
        end
      else
        table.insert(pieces, ch)
        idx = idx + 1
      end
    end

    local processed = table.concat(pieces)
    local trimmed = processed:gsub('%s*$', '')
    if trimmed ~= '' then
      processed = trimmed
      if processed:sub(-1) ~= ',' then
        processed = processed .. ','
      end
      processed = inner_indent .. processed .. '\n'
    else
      processed = ''
    end

    local closing_char = text:sub(close_pos, close_pos)
    local result
    if processed == '' then
      result = before .. '\n' .. indent .. closing_char
    else
      result = before .. '\n' .. processed .. indent .. closing_char
    end

    if after ~= '' then
      result = result .. after
    end

    return result
  end

  local function outermost_commas_transform(content)
    local text = table.concat(content.lines, '\n')
    local formatted = format_outermost_commas(text)
    return vim.split(formatted, '\n', { plain = true })
  end

  local wrap_specs = {
    { lhs = '<leader>"', left = '"', right = '"', desc = 'mini.operators: wrap selection in double quotes' },
    { lhs = "<leader>'", left = "'", right = "'", desc = 'mini.operators: wrap selection in single quotes' },
    { lhs = '<leader>(', left = '(', right = ')', desc = 'mini.operators: wrap selection in parentheses' },
    { lhs = '<leader>{', left = '{', right = '}', desc = 'mini.operators: wrap selection in braces' },
    { lhs = '<leader>[', left = '[', right = ']', desc = 'mini.operators: wrap selection in brackets' },
    { lhs = '<leader>$', left = '$', right = '$', desc = 'mini.operators: wrap selection in dollar signs' },
  }

  for _, spec in ipairs(wrap_specs) do
    make_wrap_mapping(spec.lhs, spec.left, spec.right, spec.desc)
  end

  return {
    run_visual_eval = run_visual_eval,
    format_outermost_commas = format_outermost_commas,
    outermost_commas_transform = outermost_commas_transform,
  }
end
