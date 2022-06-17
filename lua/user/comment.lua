local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

comment.setup {
  -- pre_hook = function(ctx) -- para que sirve??
  --   local U = require "Comment.utils"
  --
  --   local location = nil
  --   if ctx.ctype == U.ctype.block then
  --     location = require("ts_context_commentstring.utils").get_cursor_location()
  --   elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
  --    location = require("ts_context_commentstring.utils").get_visual_start_location()
  --   end
  --
  --   return require("ts_context_commentstring.internal").calculate_commentstring {
  --   key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
  --   location = location,
  --   }
  -- end,

  toggler = {
    line = '<leader>/',
    block = '<leader>b/'
  },

  opleader = {
    line = 'gc',
    block = 'gb'
  },

  extra = {
    ---Add comment on the line above
    above = 'gcO',
    ---Add comment on the line below
    below = 'gco',
    ---Add comment at the end of line
    eol = 'gcA',
  },

  -- mappings = {
  --   ---Operator-pending mapping
  --   ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
  --   ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
  --   basic = true,
  --   ---Extra mapping
  --   ---Includes `gco`, `gcO`, `gcA`
  --   extra = true,
  --   ---Extended mapping
  --   ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
  --   extended = false,
  -- }



}
