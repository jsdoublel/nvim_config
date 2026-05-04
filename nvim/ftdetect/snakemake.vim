au BufRead,BufNewFile *.smk,Snakemake     set filetype=snakemake

au BufEnter *.smk,Snakemake :lua vim.api.nvim_buf_set_option(0, "commentstring", "# %s")
