local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

-- to use notify
vim.notify = require("notify")

-- LSP installer config
require("user.lsp.lsp-installer")

-- Servers config
local function common_keymaps()
  vim.keymap.set('i', '<c-s>', vim.lsp.buf.signature_help, {buffer = 0})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = 0})
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer = 0})
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, {buffer = 0})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {buffer = 0}) -- not valid in python?
  vim.keymap.set('n', 'gl', vim.diagnostic.goto_next, {buffer = 0})
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, {buffer = 0})
  vim.keymap.set('n', '<leader>gl', '<cmd>Telescope diagnostics<cr>') -- <c-q> to add it to quickfix list
end

local function common_on_attach(name)
  -- on_attach common functions and parameters
  common_keymaps()
  vim.notify(name .. " attached", "info") -- TODO xk notifica todos los servers aunque no este asociados al buffer que se abre?
end

-- global config


-- connect with each server
lspconfig.pyright.setup{
  on_attach = common_on_attach("pyright"),
}

lspconfig.tsserver.setup{
  on_attach = common_on_attach('tsserver'),
}


-- old chrismachine import flow
--require "user.lsp.configs"
--require("user.lsp.handlers").setup()
require "user.lsp.null-ls"
