local function zotero_cite()
  -- Choose format based on current buffer's filetype
  local ft = vim.bo.filetype
  local format = ft:match '.*tex' and 'citep' or 'pandoc'
  local api_call = string.format('http://127.0.0.1:23119/better-bibtex/cayw?format=%s&brackets=1', format)

  -- Execute curl silently
  local handle = io.popen(string.format('curl -s %s', vim.fn.shellescape(api_call)))
  if not handle then
    return ''
  end
  local ref = handle:read '*a'
  handle:close()
  return ref
end

-- Normal mode mapping: paste citation
vim.keymap.set('n', '<leader>z', function()
  local ref = zotero_cite()
  if ref ~= '' then
    vim.api.nvim_put({ ref }, 'c', true, true)
  end
end, { desc = 'Insert Zotero citation' })

-- Insert mode mapping: insert citation inline
vim.keymap.set('i', '<C-z>', function()
  local ref = zotero_cite()
  if ref ~= '' then
    vim.api.nvim_put({ ref }, 'c', true, true)
  end
end, { desc = 'Insert Zotero citation' })
