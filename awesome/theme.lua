--      ████████╗██╗  ██╗███████╗███╗   ███╗███████╗
--      ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝
--         ██║   ███████║█████╗  ██╔████╔██║█████╗
--         ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝
--         ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗
--         ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- define module table
local theme = {}

awesome.set_preferred_icon_size(64)


-- ===================================================================
-- Theme Variables
-- ===================================================================


-- Font
theme.font = "SF Pro Text 9"
theme.top_bar_font = "SF Pro Text Regular 12"
theme.title_font = "SF Pro Display Semibold 10"

-- Background
theme.bg_normal = "#dedede99"
theme.bg_dark = "#bdbdbdff"
theme.bg_focus = "#ffffff00"
--theme.bg_focus = "#c3c3c3ff"
theme.bg_urgent = "#ed8274"
theme.bg_minimize = "#ffffffcc"
--theme.bg_systray = theme.bg_normal

--[[
theme.bg_normal = "#1f2430CC"
theme.bg_dark = "#000000"
theme.bg_focus = "#151821"
theme.bg_urgent = "#ed8274"
theme.bg_minimize = "#444444"
theme.bg_systray = theme.bg_normal
--]]
--
-- Foreground
theme.fg_normal = "#000000"
theme.fg_focus = "#1b1b1b"
theme.fg_urgent = "#000000"
theme.fg_minimize = "#000000"
--[[
theme.fg_normal = "#ffffff"
theme.fg_focus = "#e4e4e4"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"
--]]
--
-- Window Gap Distance
theme.useless_gap = dpi(20)

-- Show Gaps if Only One Client is Visible
theme.gap_single_client = true

-- Window Borders
theme.border_width = dpi(0)
theme.border_normal = theme.bg_normal
theme.border_focus = "#ff8a65"
theme.border_marked = theme.fg_urgent

-- Taglist
--theme.taglist_bg_empty = theme.bg_normal
--theme.taglist_bg_occupied = theme.bg_normal 
--theme.taglist_bg_urgent = theme.bg_normal
--theme.taglist_bg_focus = theme.bg_normal

-- Tasklist
theme.tasklist_font = theme.font

--theme.tasklist_bg_normal = theme.bg_normal
--theme.tasklist_bg_focus = theme.bg_focus
--theme.tasklist_bg_urgent = theme.bg_urgent

--theme.tasklist_fg_focus = theme.fg_focus
--theme.tasklist_fg_urgent = theme.fg_urgent
--theme.tasklist_fg_normal = theme.fg_normal

-- Panel Sizing
theme.bottom_panel_height = dpi(48)
theme.top_panel_height = dpi(26)

-- Notification Sizing
theme.notification_max_width = dpi(350)

-- ===================================================================
-- Titlebar
-- ===================================================================
theme.titlebar_height = dpi(32)
theme.titlebar_radius = 9
theme.titlebar_font = theme.title_font


theme.titlebar_button_size = dpi(14)
theme.titlebar_button_margin_horizontal = 4
theme.titlebar_button_margin_top = 0

theme.titlebar_button_close = "#ee4266"
theme.titlebar_button_minimize = "#ffb400"
theme.titlebar_button_maximize = "#4CBB17"
theme.titlebar_button_floating = "#f6a2ed"
theme.titlebar_button_ontop = "#f6a2ed"
theme.titlebar_button_sticky = "#f6a2ed"

theme.titlebar_tooltips_enabled = true
-- ===================================================================
-- Icons
-- ===================================================================

-- Top Bar Icon Sise
theme.icon_size = dpi(7)

-- You can use your own layout icons like this:
theme.layout_tile = "~/.config/awesome/icons/layouts/view-quilt.png"
theme.layout_floating = "~/.config/awesome/icons/layouts/view-float.png"
theme.layout_max = "~/.config/awesome/icons/layouts/arrow-expand-all.png"

theme.icon_theme = "Tela-dark"

-- Return Theme
return theme
