local lint = require('lint')
lint.linters_by_ft = {
  go = {'golangcilint'},
}
lint.linters.codespell.args = { '--stdin-single-line', "-" , "--config", "/home/jsdoublel/.config/.codespellrc"}
