--       █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗
--      ██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝
--      ███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗
--      ██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝
--      ██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗
--      ╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Import theme
local beautiful = require("beautiful")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- Import Titlebars (Nice Titlebars)
local nice = require("widgets.nice")
nice()

-- Import Keybinds
local keys = require("keys")
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

-- Import rules
local create_rules = require("rules").create
awful.rules.rules = create_rules(keys.clientkeys, keys.clientbuttons)

-- Import notification appearance
require("components.notifications")

-- Import components
require("components.wallpaper")
require("components.exit-screen")
require("components.volume-adjust")

-- Autostart specified apps
local apps = require("apps")
apps.autostart()

local treetile = require("treetile")

local icon_dir = os.getenv("HOME") .. "/.config/awesome/icons/tags/"

-- ===================================================================
-- Set Up Screen & Connect Signals
-- ===================================================================

-- Define tag layouts
awful.layout.layouts = {
   treetile,
   awful.layout.suit.tile,
   --awful.layout.suit.floating,
   --awful.layout.suit.max,
   --awful.layout.suit.fair
}

-- Import tag settings
local tags = require("tags")

-- Import panels
local bottom_panel = require("components.bottom-panel")
local top_panel = require("components.top-panel")

-- Set up each screen (add tags & panels)
awful.screen.connect_for_each_screen(function(s)
   for i, tag in pairs(tags) do
      awful.tag.add(i, {
         icon = tag.icon,
         icon_only = true,
         layout = treetile,
         --layout = awful.layout.suit.tile,
         screen = s,
         selected = i == 1
      })
   end

   -- Only add the bottom panel on the primary screen
   if s.index == 1 then
      bottom_panel.create(s)
   end

   -- Add the top panel to every screen
   top_panel.create(s)
end)

--set initally selected tag to be active
local initial_tag = awful.screen.focused().selected_tag
awful.tag.seticon(icon_dir .. "activeTag.png", initial_tag)

-- updates tag icons
local function update_tag_icons()
   -- get a list of all tags
   local atags = awful.screen.focused().tags

   -- update each tag icon
   for i, t in ipairs(atags) do
      -- don't update active tag icon
      if t == awful.screen.focused().selected_tag then
         goto continue
      end
      -- if the tag has clients use busy icon
      for _ in pairs(t:clients()) do
         awful.tag.seticon(icon_dir .. "filledTag.png", t)
         goto continue
      end
      -- if the tag has no clients use regular inactive icon
      awful.tag.seticon(icon_dir .. "emptyTag.png", t)

      ::continue::
   end
end

-- Update tag icons when tag is switched
tag.connect_signal("property::selected", function(t)                                                                                                                                                                      
   -- set newly selected tag icon as active
   awful.tag.seticon(icon_dir .."activeTag.png", t)
   update_tag_icons()
end)

-- Update tag icons when a client is moved to a new tag
tag.connect_signal("tagged", function(c)
   update_tag_icons()
end)

-- remove gaps if layout is set to max
tag.connect_signal('property::layout', function(t)
   local current_layout = awful.tag.getproperty(t, 'layout')
   if (current_layout == awful.layout.suit.max) then
      t.gap = 0
   else
      t.gap = beautiful.useless_gap
   end
end)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
   -- Set the window as a slave (put it at the end of others instead of setting it as master)
   if not awesome.startup then
      awful.client.setslave(c)
   end

   if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
   end
   --[[
    if (current_layout ~= awful.layout.suit.max) then
        c.shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,20)
       
        end
    end
    --]]

end)



-- ===================================================================
-- Client Focusing
-- ===================================================================


-- Autofocus a new client when previously focused one is closed
require("awful.autofocus")

-- Focus clients under mouse
client.connect_signal("mouse::enter", function(c)
   c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)


-- ===================================================================
-- Garbage collection (allows for lower memory consumption)
-- ===================================================================


collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
