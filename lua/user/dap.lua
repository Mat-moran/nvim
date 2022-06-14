-- Explore: -- From tjdvries
-- - External terminal
-- - make the virt lines thing available if ppl want it
-- - find the nearest codelens above cursor

-- Must Show:
-- - Connect to an existing neovim instance, and step through some plugin
-- - Connect using configuration from VS **** json file (see if VS **** is actually just "it works" LUL)
-- - Completion in the repl, very cool for exploring objects / data


local has_dap, dap = pcall(require, "dap")
if not has_dap then
  return
end

local map = function(lhs, rhs, desc)
  if desc then
    desc = "[DAP] " .. desc
  end -- TODO fallback a rhs si no hay descripcion

  vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end


map("<F1>", require("dap").step_back, "step_back")
map("<F2>", require("dap").step_into, "step_into")
map("<F3>", require("dap").step_over, "step_over")
map("<F4>", require("dap").step_out, "step_out")
map("<F5>", require("dap").continue, "continue")

map("<leader>dr", require("dap").repl.open, "TODO poner descripcion")
map("<leader>db", require("dap").toggle_breakpoint, 'toogle_breakpoint')

map("<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input "[DAP] Condition > ")
end, "Set breakpoint with a specific contition")

map("<leader>de", require("dapui").eval)

map("<leader>dE", function()
  require("dapui").eval(vim.fn.input "[DAP] Expression > ")
end)



-- vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
-- vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
require("nvim-dap-virtual-text").setup()

-- dap-python config
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Build api",
    program = "${file}",
    args = { "--target", "api" },
    console = "integratedTerminal",
  },
  {
    type = "python",
    request = "launch",
    name = "Launch Odoo",
    program = "", -- TODO lanzar odoo desde aqui en modo debug
    args = {},
    console = "integratedTerminal",
  },
}

local dap_python = require "dap-python"
dap_python.setup('~/.virtualenvs/debugpy/bin/python', {
  console = "externalTerminal",
  include_configs = true,
})

-- dap-ui configuration
local dap_ui = require "dapui"
local _ = dap_ui.setup {
  -- You can change the order of elements in the sidebar
  sidebar = {
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.75, -- Can be float or integer > 1
      },
      { id = "watches", size = 00.25 },
    },
    size = 50,
    position = "left", -- Can be "left" or "right"
  },

  tray = {
    elements = {},
    size = 15,
    position = "bottom", -- Can be "bottom" or "top"
  },
}

-- from here i do not know what the code is doing -- tjdvries config
local original = {}
local debug_map = function(lhs, rhs, desc)
  local keymaps = vim.api.nvim_get_keymap "n"
  original[lhs] = vim.tbl_filter(function(v)
    return v.lhs == lhs
  end, keymaps)[1] or true

  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

local debug_unmap = function()
  for k, v in pairs(original) do
    if v == true then
      vim.keymap.del("n", k)
    else
      local rhs = v.rhs

      v.lhs = nil
      v.rhs = nil
      v.buffer = nil
      v.mode = nil
      v.sid = nil
      v.lnum = nil

      vim.keymap.set("n", k, rhs, v)
    end
  end

  original = {}
end




dap.listeners.after.event_initialized["dapui_config"] = function()
  debug_map("asdf", ":echo 'hello world<CR>", "showing things")

  dap_ui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  debug_unmap()

  dap_ui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dap_ui.close()
end

