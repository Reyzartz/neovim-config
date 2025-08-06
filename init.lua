print("My Personal Hell")

require("config.lazy")

-- VIM OPTIONS SETTINGS
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"

-- TEMPORARY FIXES
vim.hl = vim.highlight

-- KEYMAP TO COMPLILE LUA CONFIG
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":.lua<CR>")

-- UPCOMING SHORTCUTS
vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
vim.keymap.set('n', 'grr', vim.lsp.buf.references)


-- TERMINAL COMMANDS
vim.keymap.set('n', '<space>to', function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
  vim.cmd(":startinsert")
end, {
  noremap = true,
  desc = "Open terminal in a new window",
})

-- WINDOW COMMANDS
vim.keymap.set('n', '<space>w', function()
  vim.cmd.vnew()
  vim.cmd.wincmd("L")
end, {
  noremap = true,
  desc = "Open window in a new window vertically",
})

vim.keymap.set('n', '<space>wh', function()
  vim.cmd.new()
  vim.cmd.wincmd("J")
end, {
  noremap = true,
  desc = "Open window in a new window horizontally",
})


-- Keymap to trigger the function
vim.keymap.set('n', '<Leader>d', function()
  local bufnr = vim.api.nvim_create_buf(false, true) -- Create an empty buffer
  local width = 120                                   -- Set the width of the floating window
  local height = 40                                  -- Set the height of the floating window

  -- Get the current window dimensions
  local win_width = vim.o.columns
  local win_height = vim.o.lines

  -- Calculate the position to center the window
  local row = math.floor((win_height - height) / 2)
  local col = math.floor((win_width - width) / 2)

  local opts = {
    style = "minimal",
    relative = "win",
    width = width,
    height = height,
    row = row,
    col = col,
    border = "rounded",
  }

  vim.lsp.buf.hover()


  -- Open the floating window
  vim.api.nvim_open_win(bufnr, true, opts)
end, { noremap = true, silent = true })




-- TABS COMMANDS
vim.keymap.set('n', '<space>t', function()
  vim.cmd.tabnew()
end, {
  noremap = true,
  desc = "Open tab in a new window",
})

vim.keymap.set('n', '<space>tt', function()
  vim.cmd.tabnew()
  vim.cmd.term()
  vim.cmd("startinsert")
end, {
  noremap = true,
  desc = "Open tab in a new window and open terminal",
})

-- DIAGNOSTIC COMMANDS
vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, { noremap = true, desc = "Open diagnostic float" })
vim.keymap.set('n', '<space>l', vim.diagnostic.setloclist, { noremap = true, desc = "Open diagnostic loclist" })
vim.keymap.set('n', '<space>q', vim.diagnostic.setqflist, { noremap = true, desc = "Open diagnostic quickfix" })

vim.keymap.set('t', '<esc>', '<C-\\><C-N>', { silent = true, noremap = true })

-- EVENT HANDLERS

-- HIGHLIGHT WHEN TEXT IS YANKED
vim.api.nvim_create_autocmd('textyankpost', {
  desc = "highlight when yanking the text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),

  callback = function()
    vim.highlight.on_yank()
  end,
})

-- OPEN NEW FILES IN INSERT MODE
vim.api.nvim_create_autocmd('BufNewFile', {
  desc = "Set's the mode to insert after creating a new file",
  group = vim.api.nvim_create_augroup("kickstart-set-mode-to-insert", { clear = true }),

  callback = function()
    vim.cmd(":startinsert")
  end,
})

-- OPEN NEW TERMINALS IN A NEW WINDOW
vim.api.nvim_create_autocmd('TermOpen', {
  desc = "Open terminal in a new window",
  group = vim.api.nvim_create_augroup("open-terminal", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- AUTOSAVE WHEN EXITING INSERT MODE
vim.api.nvim_create_autocmd('InsertLeave', {
  desc = "Saves the file when exiting insert mode",
  group = vim.api.nvim_create_augroup("kickstart-save-file", { clear = true }),

  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.bo.buftype == "" then
      vim.cmd("write")
      print("File Saved")
    end
  end,
})
