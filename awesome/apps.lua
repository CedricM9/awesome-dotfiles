--       █████╗ ██████╗ ██████╗ ███████╗
--      ██╔══██╗██╔══██╗██╔══██╗██╔════╝
--      ███████║██████╔╝██████╔╝███████╗
--      ██╔══██║██╔═══╝ ██╔═══╝ ╚════██║
--      ██║  ██║██║     ██║     ███████║
--      ╚═╝  ╚═╝╚═╝     ╚═╝     ╚══════╝


-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local filesystem = require("gears.filesystem")

-- define module table
local apps = {}


-- ===================================================================
-- App Declarations
-- ===================================================================


-- define default apps
apps.default = {
   terminal = "alacritty",
   launcher = "rofi -show drun -theme config",
   lock = "i3lock -c 00000000 --blur 5",
   --screenshot = "scrot ~/Desktop/%b\ %d\ -\ %H:%M.png",
   filebrowser = "nautilus",
   ranger = "ranger",
   network = "nm-applet"
}

-- List of apps to start once on start-up
local run_on_start_up = {
   "picom",
   "redshift",
   'xinput set-prop "DLL08B0:01 06CB:CD7A Touchpad" "libinput Tapping Enabled" 1',
   "unclutter",
   "xfce4-power-manager",
   "bluez",
   "blueman",
   --"nm-applet",
   'xinput set-prop "DLL08B0:01 06CB:CD7A Touchpad" "libinput Natural Scrolling Enabled" 1',
   'xinput set-prop "MX Master 2S Mouse" 174 0.6 0 0 0 0.6 0 0 0 1',
   'bluetoothctl power on'
}


-- ===================================================================
-- Functionality
-- ===================================================================


-- Run all the apps listed in run_on_start_up
function apps.autostart()
   for _, app in ipairs(run_on_start_up) do
      local findme = app
      local firstspace = app:find(" ")
      if firstspace then
         findme = app:sub(0, firstspace - 1)
      end
         awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, app), false)
   end
end

return apps
