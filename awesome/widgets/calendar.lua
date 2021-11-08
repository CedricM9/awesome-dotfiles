--       ██████╗ █████╗ ██╗     ███████╗███╗   ██╗██████╗  █████╗ ██████╗
--      ██╔════╝██╔══██╗██║     ██╔════╝████╗  ██║██╔══██╗██╔══██╗██╔══██╗
--      ██║     ███████║██║     █████╗  ██╔██╗ ██║██║  ██║███████║██████╔╝
--      ██║     ██╔══██║██║     ██╔══╝  ██║╚██╗██║██║  ██║██╔══██║██╔══██╗
--      ╚██████╗██║  ██║███████╗███████╗██║ ╚████║██████╔╝██║  ██║██║  ██║
--       ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝


-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local click_to_hide = require("utilities/click_to_hide")
local dpi = beautiful.xresources.apply_dpi


-- ===================================================================
-- Create Widget
-- ===================================================================


-- Clock / Calendar 12h format
-- Get Time/Date format using `man strftime
-- local clock_widget = wibox.widget.textclock("<span font='" .. beautiful.title_font .."'>%l:%M %p</span>",1)
local clock_widget = wibox.widget.textclock("<span font='" .. beautiful.top_bar_font .."'>%H:%M</span>", 1)

-- Alternative to naughty.notify - tooltip. You can compare both and choose the preferred one
awful.tooltip({
   objects = {clock_widget},
   mode = "outside",
   align = "bottom",
   timer_function = function()
      return os.date("%B %d, %Y (%A)")
   end,
   preferred_positions = {"right", "left", "top", "bottom"},
   margin_leftright = dpi(14),
   margin_topbottom = dpi(14)
})

local cal_shape = function(cr, width, height)
   gears.shape.partially_rounded_rect(cr, width, height, true, true, true, true, 20)
end

-- Calendar Widget
local month_calendar = awful.widget.calendar_popup.month({
   start_sunday = false,
   spacing = 10,
   font = beautiful.title_font,
   long_weekdays = true,
   margin = 20, -- 10
   style_month = {border_width = 0, padding = 12, shape = cal_shape, padding = 25},
   style_header = {border_width = 0, bg_color = "#00000000"},
   style_weekday = {border_width = 0, bg_color = "#00000000"},
   style_normal = {border_width = 0, bg_color = "#00000000"},
   style_focus = {border_width = 0, bg_color = "#8AB4F8"},
})

--Closes Popup if mouse is pressed anywhere on screen
click_to_hide.popup(month_calendar)

-- Attach calentar to clock_widget
month_calendar:attach(clock_widget, "tc" , { on_pressed = true, on_hover = false })

return clock_widget
