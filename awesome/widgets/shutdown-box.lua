local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")
local clickable_container = require('widgets.clickable-container')
local gears = require("gears")
local apps = require("apps").default
local dpi = require("beautiful").xresources.apply_dpi

local PATH_TO_ICONS = os.getenv("HOME") .. "/.config/awesome/icons/"

local icon_size = beautiful.icon_size

-- ===================================================================
-- Widget Creation
-- ===================================================================


-- Create an imagebox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.


local widget = wibox.widget {
    {
        id = "icon",
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}


local widget_button = clickable_container(wibox.container.margin(widget, icon_size, icon_size, icon_size, icon_size))
widget_button:buttons(
    gears.table.join(
        awful.button({}, 1, nil,
            function()
               awesome.emit_signal("show_exit_screen") 
            end
        ),
        awful.button({}, 3, nil,
               awesome.restart 
        )
    )
)

widget.icon:set_image(PATH_TO_ICONS .. "shutdown.png")


return widget_button
