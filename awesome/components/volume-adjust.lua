--      ██╗   ██╗ ██████╗ ██╗     ██╗   ██╗███╗   ███╗███████╗
--      ██║   ██║██╔═══██╗██║     ██║   ██║████╗ ████║██╔════╝
--      ██║   ██║██║   ██║██║     ██║   ██║██╔████╔██║█████╗
--      ╚██╗ ██╔╝██║   ██║██║     ██║   ██║██║╚██╔╝██║██╔══╝
--       ╚████╔╝ ╚██████╔╝███████╗╚██████╔╝██║ ╚═╝ ██║███████╗
--        ╚═══╝   ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝


-- ===================================================================
-- Initialization
-- ===================================================================


local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local offsetx = dpi(56)
local offsety = dpi(360)
local screen = awful.screen.focused()
local icon_dir = gears.filesystem.get_configuration_dir() .. "/icons/volume/"


-- ===================================================================
-- Appearance & Functionality
-- ===================================================================


local volume_icon = wibox.widget {
   widget = wibox.widget.imagebox
}

-- create the volume_adjust component
local volume_adjust = wibox({
   screen = awful.screen.focused(),
   x = (screen.geometry.width / 2) - (offsety / 2),
   y = offsety * (2/3),
   width = offsety,
   height = offsetx,
   shape = gears.shape.rounded_rect,
   visible = false,
   ontop = true
})

local volume_bar = wibox.widget{
   widget = wibox.widget.progressbar,
   shape = gears.shape.rounded_bar,
   color = "#efefef",
   background_color = beautiful.bg_focus,
   max_value = 100,
   value = 0
}

volume_adjust:setup {
   layout = wibox.layout.align.horizontal,
   {
      wibox.container.margin(
         volume_bar, dpi(20), dpi(20), dpi(20), dpi(20)
      ),
      forced_height = offsety * 0.75,
      direction = "north",
      layout = wibox.container.rotate
   },
   wibox.container.margin(
      volume_icon
   )
}

-- create a 4 second timer to hide the volume adjust
-- component whenever the timer is started
local hide_volume_adjust = gears.timer {
   timeout = 4,
   autostart = true,
   callback = function()
      volume_adjust.visible = false
   end
}

-- show volume-adjust when "volume_change" signal is emitted
awesome.connect_signal("volume_change",
   function()
      -- set new volume value
      awful.spawn.easy_async_with_shell(
         "pactl list sinks | grep '^[[:space:]]Volume:' | \\head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \\([0-9][0-9]*\\)%.*,\\1,'",
         function(stdout)
            local volume_level = tonumber(stdout)
            volume_bar.value = volume_level
            if (volume_level > 40) then
               volume_icon:set_image(icon_dir .. "volume.png")
            elseif (volume_level > 0) then
               volume_icon:set_image(icon_dir .. "volume-low.png")
            else
               volume_icon:set_image(icon_dir .. "volume-off.png")
            end
         end,
         false
      )

      -- make volume_adjust component visible
      if volume_adjust.visible then
         hide_volume_adjust:again()
      else
         volume_adjust.visible = true
         hide_volume_adjust:start()
      end
   end
)
