--      ██╗     ███████╗███████╗████████╗    ██████╗  █████╗ ███╗   ██╗███████╗██╗
--      ██║     ██╔════╝██╔════╝╚══██╔══╝    ██╔══██╗██╔══██╗████╗  ██║██╔════╝██║
--      ██║     █████╗  █████╗     ██║       ██████╔╝███████║██╔██╗ ██║█████╗  ██║
--      ██║     ██╔══╝  ██╔══╝     ██║       ██╔═══╝ ██╔══██║██║╚██╗██║██╔══╝  ██║
--      ███████╗███████╗██║        ██║       ██║     ██║  ██║██║ ╚████║███████╗███████╗
--      ╚══════╝╚══════╝╚═╝        ╚═╝       ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi
local awful = require("awful")
local gears = require("gears")

--local tag_list = require("widgets.tag-list")
local task_list = require("widgets.task-list")
local separator = require("widgets.horizontal-separator")
local folder = require("widgets.folder")

local home_dir = os.getenv("HOME")

-- define module table
local bottom_panel = {}


-- ===================================================================
-- Bar Creation
-- ===================================================================


bottom_panel.create = function(s)

   local panel_shape = function(cr, width, height)
      gears.shape.partially_rounded_rect(cr, width, height, true, true, false, false, 16)
   end
   local maximized_panel_shape = function(cr, width, height)
      gears.shape.rectangle(cr, width, height)
   end

   panel = awful.wibox({
      screen = s,
      position = "bottom",
      height = beautiful.bottom_panel_height,
      width = beautiful.bottom_panel_width,
      ontop = true,
      shape = panel_shape
   })

   panel:setup {
      expand = "none",
      layout = wibox.layout.align.horizontal,
      nil,
      {
         layout = wibox.layout.fixed.horizontal,
	 task_list.create(s),
      },
      nil
   }

   --[[
   -- panel background that becomes visible when client is maximized
   panel_bg = wibox({
    screen = s,
    x = 0,
    y = s.geometry.height - beautiful.bottom_panel_height,
    --position = "bottom",
    height = beautiful.bottom_panel_height,
    width = s.geometry.width / 3,
    visible = false,
    ontop = true
    })
--]]
 
  
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

   -- maximize panel if client is maximized
   local function toggle_maximize_bottom_panel(is_maximized)
      --panel_bg.visible = is_maximized
      if is_maximized then
         panel.shape = maximized_panel_shape
         panel.width = s.geometry.width
      else
         panel.shape = panel_shape
         panel.width = beautiful.bottom_panel_width
      end
   end

   -- maximize if a client is maximized
   client.connect_signal("property::maximized", function(c)
      toggle_maximize_bottom_panel(c.maximized)
   end)

   client.connect_signal("manage", function(c)
      if awful.tag.getproperty(c.first_tag, "layout") == awful.layout.suit.max then
         toggle_maximize_bottom_panel(true)
      end
   end)

   -- unmaximize if a client is removed and there are no maximized clients bottom
   client.connect_signal("unmanage", function(c)
      local t = awful.screen.focused().selected_tag
      -- if client was maximized
      if c.maximized then
         -- check if any clients that are open are maximized
         for _, c in pairs(t:clients()) do
            if c.maximized then
               return
            end
         end
         toggle_maximize_bottom_panel(false)

      -- if tag was maximized
      elseif awful.tag.getproperty(t, "layout") == awful.layout.suit.max then
         -- check if any clients are open (and therefore maximized)
         for _ in pairs(t:clients()) do
            return
         end
         toggle_maximize_bottom_panel(false)
      end
   end)

   -- maximize if layout is maximized and a client is in the layout
   tag.connect_signal("property::layout", function(t)
      -- check if layout is maximized
      if (awful.tag.getproperty(t, "layout") == awful.layout.suit.max) then
         -- check if clients are open
         for _ in pairs(t:clients()) do
            toggle_maximize_bottom_panel(true)
            return
         end
         toggle_maximize_bottom_panel(false)
      else
         toggle_maximize_bottom_panel(false)
      end
   end)

   -- maximize if a tag is swapped to with a maximized client
   tag.connect_signal("property::selected", function(t)
      -- check if layout is maximized
      if (awful.tag.getproperty(t, "layout") == awful.layout.suit.max) then
         -- check if clients are open
         for _ in pairs(t:clients()) do
            toggle_maximize_bottom_panel(true)
            return
         end
         toggle_maximize_bottom_panel(false)
      else
         -- check if any clients that are open are maximized
         for _, c in pairs(t:clients()) do
            if c.maximized then
               toggle_maximize_bottom_panel(true)
               return
            end
         end
         toggle_maximize_bottom_panel(false)
      end
   end)
end

return bottom_panel
