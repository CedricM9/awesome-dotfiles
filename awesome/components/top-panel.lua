--      ████████╗ ██████╗ ██████╗     ██████╗  █████╗ ███╗   ██╗███████╗██╗
--      ╚══██╔══╝██╔═══██╗██╔══██╗    ██╔══██╗██╔══██╗████╗  ██║██╔════╝██║
--         ██║   ██║   ██║██████╔╝    ██████╔╝███████║██╔██╗ ██║█████╗  ██║
--         ██║   ██║   ██║██╔═══╝     ██╔═══╝ ██╔══██║██║╚██╗██║██╔══╝  ██║
--         ██║   ╚██████╔╝██║         ██║     ██║  ██║██║ ╚████║███████╗███████╗
--         ╚═╝    ╚═════╝ ╚═╝         ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local clickable_container = require('widgets.clickable-container')
local dpi = beautiful.xresources.apply_dpi

-- import widgets
local task_list = require("widgets.task-list")
local tag_list = require("widgets.tag-list")
local launcher_box = require("widgets.launcher-box")
local calendar = require("widgets.calendar")
local network_box = require("widgets.network")
local bluetooth = require("widgets.bluetooth")
local battery = require("widgets.battery")
local layout_box = require("widgets.layout-box")
local shutdown_box = require("widgets.shutdown-box")
local volume_widget = require('widgets.volume.volume-widget')
local layout_indicator = require("widgets.keyboard-layout")


local icon_size = beautiful.icon_size

--Define Keyboard Layouts
kbdcfg = layout_indicator({
   layouts = {
      {name="DE",  layout="de",  variant=nil},
      {name="US",  layout="us",  variant=nil}
   }
})


-- define module table
local top_panel = {}

-- ===================================================================
-- Bar Creation
-- ===================================================================

kbdcfg.widget.font = beautiful.title_font

local volume_box = clickable_container(wibox.container.margin(volume_widget(), icon_size, icon_size, icon_size, icon_size))
local calendar_box = clickable_container(wibox.container.margin(calendar, icon_size, icon_size, -dpi(2), dpi(0)))
local keyboard_box = clickable_container(wibox.container.margin(kbdcfg.widget, icon_size, icon_size, -dpi(1), dpi(1)))

top_panel.create = function(s)
   local panel = awful.wibar({
      screen = s,
      position = "top",
      ontop = true,
      height = beautiful.top_panel_height,
      width = s.geometry.width,
   })

   panel:setup {
      expand = "none",
      layout = wibox.layout.align.horizontal,
      { --Left Widgets
        layout = wibox.layout.fixed.horizontal,
	launcher_box,
        tag_list.create(s),
      },

      calendar_box,
      --calendar,
      { --Right Widgets
         layout = wibox.layout.fixed.horizontal,
         wibox.layout.margin(wibox.widget.systray(), 0, 0, 3, 3),

	 battery,
	 keyboard_box,
	 bluetooth,
     network_box(),
	 volume_box,
	 shutdown_box,
	 layout_box
      }
   }


   -- ===================================================================
   -- functionality
   -- ===================================================================


   -- hide panel when client is fullscreen
   local function change_panel_visibility(client)
      panel.ontop = not client.fullscreen
   end

   -- connect panel visibility function to relevant signals
   client.connect_signal("property::fullscreen", change_panel_visibility)
   client.connect_signal("focus", change_panel_visibility)
   client.connect_signal("unfocus", change_panel_visibility)

end

return top_panel
