vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'},
  { desc = 'Set filetype to Swift IR'
  , pattern = '*.sil'
  , callback = function()
      vim.opt_local.filetype='sil'
    end
  })

