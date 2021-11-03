local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi

local widget = {}

local icon_dir = os.getenv("HOME") .. '/.config/awesome/icons/volume/'

function widget.get_widget(widgets_args)
    --local args = widgets_args or {}

    return wibox.widget {
        {
            id = "icon",
            widget = wibox.widget.imagebox,
            resize = true,
        },
        valign = 'center',
	layout = wibox.container.place,
        --layout = wibox.layout.align.horizontal(middle),
        set_volume_level = function(self, new_value)
            local volume_icon_name
            if self.is_muted then
                volume_icon_name = 'volume-off.png'
            else
                local new_value_num = tonumber(new_value)
                if (new_value_num >= 0 and new_value_num < 40) then
                    volume_icon_name="volume-low.png"
                else
                    volume_icon_name="volume.png"
                end
            end
            self:get_children_by_id('icon')[1]:set_image(icon_dir .. volume_icon_name)
        end,
        mute = function(self)
            self.is_muted = true
            self:get_children_by_id('icon')[1]:set_image(icon_dir .. 'volume-mute.png')
        end,
        unmute = function(self)
            self.is_muted = false
        end
    }
end

return widget
