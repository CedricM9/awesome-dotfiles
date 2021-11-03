--      ██╗      █████╗ ██╗   ██╗ ██████╗ ██╗   ██╗████████╗    ██████╗  ██████╗ ██╗  ██╗
--      ██║     ██╔══██╗╚██╗ ██╔╝██╔═══██╗██║   ██║╚══██╔══╝    ██╔══██╗██╔═══██╗╚██╗██╔╝
--      ██║     ███████║ ╚████╔╝ ██║   ██║██║   ██║   ██║       ██████╔╝██║   ██║ ╚███╔╝
--      ██║     ██╔══██║  ╚██╔╝  ██║   ██║██║   ██║   ██║       ██╔══██╗██║   ██║ ██╔██╗
--      ███████╗██║  ██║   ██║   ╚██████╔╝╚██████╔╝   ██║       ██████╔╝╚██████╔╝██╔╝ ██╗
--      ╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝  ╚═════╝    ╚═╝       ╚═════╝  ╚═════╝ ╚═╝  ╚═╝

-- ===================================================================
-- Initialization
-- ===================================================================

local beautiful = require('beautiful')
local clickable_container = require('widgets.clickable-container')
local awful = require('awful')
local wibox = require('wibox')

local icon_size = beautiful.icon_size

-- ===================================================================
-- Widget Creation
-- ===================================================================


-- Create an imagebox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
local layout_box = clickable_container(wibox.container.margin(awful.widget.layoutbox(s), icon_size, icon_size, icon_size, icon_size))

layout_box:buttons(
   awful.util.table.join(
      awful.button({}, 1,
         function()
            awful.layout.inc(1)
         end
      ),
      awful.button({}, 3,
         function()
            awful.layout.inc(-1)
         end
      ),
      awful.button({}, 4,
         function()
            awful.layout.inc(1)
         end
      ),
      awful.button({}, 5,
         function()
            awful.layout.inc(-1)
         end
      )
   )
)

return layout_box
