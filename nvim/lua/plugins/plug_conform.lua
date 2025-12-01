return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      -- local disable_filetypes = { c = true, cpp = true }
      local disable_filetypes = {}
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters = {
      typstyle = {
        prepend_args = {
          '--wrap-text',
          '--line-width',
          '100',
        },
      },
    },

    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      python = { 'black' },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      typescript = { 'prettierd' },
      javascript = { 'prettierd', 'eslint', 'prettier', stop_after_first = true },
      markdown = { 'prettier' },
      typst = { 'typstyle' },
    },

    formatters = {
      prettier = {
        -- Options: "always" (wrap), "never" (unwrap), "preserve" (default)
        prepend_args = { '--prose-wrap', 'always', '--print-width', '100' },
      },
    },
  },
}
