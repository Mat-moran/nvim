-- TODO convert to the lua native api vim.keymap.set() with a map function
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- migration to lua native keymap set
local map = function(m, lhs, rhs, desc) -- TODO permitir pasarle opciones dinamicas
  if desc then
     desc =  desc
  else
    desc = rhs -- TODO esto da problemas si rhs no es string
  end

  vim.keymap.set(m, lhs, rhs, { silent = true, desc = desc })
end

local buf_map = function(m, lhs, rhs)
  vim.keymap.set(m, lhs, rhs, { buffer = 0})
end

-- Buffers
map("n","<leader>c", "<cmd>Bdelete!<cr>", "[BUF] close buffer")

-- nvim tree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", "[NVIM TREE] open explorer")

-- telescope
map("n","<leader>sf", require("telescope.builtin").find_files, "[telescope] find_files")
map('n',"<leader>st", require("telescope.builtin").live_grep, "[telescope] grep_string")
map('n',"<leader>su", require("telescope.builtin").grep_string, "[telescope] grep_string")


-- dap
map("n","<F1>", require("dap").step_back, "[DEBUG] step_back")
map("n","<F2>", require("dap").step_into, "[DEBUG] step_into")
map("n","<F3>", require("dap").step_over, "[DEBUG] step_over")
map("n","<F4>", require("dap").step_out, "[DEBUG] step_out")
map("n","<F5>", require("dap").continue, "[DEBUG] continue")
map("n","<leader>dr", require("dap").repl.open, "[DEBUG] repl.open")
map("n","<leader>db", require("dap").toggle_breakpoint, '[DEBUG] toogle breakpoint')
map("n","<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input "[DEBUG] Condition > ")
end, "[DEBUG] Set breakpoint with a specific contition")
map("n","<leader>de", require("dapui").eval)
map("n","<leader>dE", function()
  require("dapui").eval(vim.fn.input "[DEBUG] Expression > ")
end)

-- lazygit
map('n', '<leader>gg', "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit", '[git] open lazygit')
map('n', '<leader>gb', "<cmd>lua require 'gitsigns'.blame_line()<cr>", "[git] Blame line")
-- map('n',"<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
-- map("<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
-- map("<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
-- map("<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
-- map("<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
-- map("<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },

-- lsp
buf_map('i', '<c-s>', vim.lsp.buf.signature_help)
buf_map('n', 'K', vim.lsp.buf.hover)
buf_map('n', 'gd', vim.lsp.buf.definition)
buf_map('n', 'gt', vim.lsp.buf.type_definition)
buf_map('n', 'gi', vim.lsp.buf.implementation) -- not valid in python?
buf_map('n', 'gl', vim.diagnostic.goto_next)
buf_map('n', '<leader>r', vim.lsp.buf.rename)
buf_map('n', '<leader>gl', '<cmd>Telescope diagnostics<cr>') -- <c-q> to add it to quickfix list

