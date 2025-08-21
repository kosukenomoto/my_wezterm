local wezterm = require 'wezterm'
local config = {}

config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 150,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 150,
}
config.colors = {
  visual_bell = '#202020',
}

config.font = wezterm.font 'UDEV Gothic NF'
config.color_scheme = 'Ayu Dark (Gogh)'
config.font_size = 12.0
config.initial_rows = 40
config.initial_cols = 150

-- 背景の非透過率（1なら完全に透過させない）
config.window_background_opacity = 0.8
-- 他にもオプションを組み合わせるときれいになるよ
config.enable_wayland = true -- Linux Waylandなら有効にしておく
config.enable_tab_bar= false

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

-- フォントサイズ変更関数を返すユーティリティ
local function set_font_size(size)
  return wezterm.action_callback(function(window, pane)
    local overrides = window:get_config_overrides() or {}
    overrides.font_size = size
    window:set_config_overrides(overrides)
  end)
end


config.disable_default_key_bindings = true

config.keys = {
  -- コピー
  { key = "c", mods = "SHIFT|CTRL", action = wezterm.action.CopyTo("Clipboard") },
  -- 貼り付け
  { key = "v", mods = "SHIFT|CTRL", action = wezterm.action.PasteFrom("Clipboard") },
  { key = '9', mods = 'ALT|CTRL', action = set_font_size(18) },
  { key = '0', mods = 'ALT|CTRL', action = set_font_size(14) },
}
return config
