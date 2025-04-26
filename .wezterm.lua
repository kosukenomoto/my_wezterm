local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'UDEV Gothic NF'
config.color_scheme = 'Ayu Dark (Gogh)'
config.font_size = 14.0

-- 背景の非透過率（1なら完全に透過させない）
config.window_background_opacity = 0.85
-- 背景をぼかす
config.macos_window_background_blur = 20

config.window_decorations = 'RESIZE'
config.window_padding = {
  left = 2,
  right = 2,
  top = 0,
  bottom = 0,
}


wezterm.on('update-right-status', function(window, pane)
  -- "Wed Mar 3 08:14"
  local date = wezterm.strftime '%a %b %-d %H:%M '
  local bat = ''
  for _, b in ipairs(wezterm.battery_info()) do
    bat = '🔋 ' .. string.format('%.0f%%', b.state_of_charge * 100)
  end
  window:set_right_status(wezterm.format {
    { Text = bat .. '   ' .. date },
  })
end)

local act = wezterm.action
config.keys = {
  { key = ',', mods = 'CTRL|ALT', action = act.ActivateTabRelative(-1) },
  { key = '.', mods = 'CTRL|ALT', action = act.ActivateTabRelative(1) },
  { key = 'm', mods = 'CTRL|ALT', action = act.SpawnTab('CurrentPaneDomain') },
}

return config
