vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'},
  { desc = 'Set filetype to LLVM'
  , pattern = '*.ll'
  , callback = function()
      vim.opt_local.filetype='llvm'
    end
  })

