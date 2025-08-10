local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'UDEV Gothic NF'
-- config.color_scheme = 'Ayu Dark (Gogh)'
config.font_size = 14.0
config.initial_rows = 40
config.initial_cols = 120 

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


-- 背景の非透過率（1なら完全に透過させない）
config.window_background_opacity = 0.92
-- 他にもオプションを組み合わせるときれいになるよ
config.enable_wayland = true -- Linux Waylandなら有効にしておく

config.enable_tab_bar = false
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = {
  left = 4,
  right = 4,
  top = 0 ,
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

-- 既存の require と config 定義の後に貼るだけで OK
local function toggle_borderless_fullscreen()
  return wezterm.action_callback(function(window, pane)
    local dims      = window:get_dimensions()
    local overrides = window:get_config_overrides() or {}

    if dims.is_full_screen then
      -- フルスクリーン解除：元に戻す
      overrides.window_decorations           = nil
      overrides.window_padding               = nil
      overrides.hide_tab_bar_if_only_one_tab = nil
      window:set_config_overrides(overrides)
      window:toggle_fullscreen()
    else
      -- フルスクリーン突入：全部消す
      overrides.window_decorations           = "NONE"
      overrides.window_padding               = { left = 0, right = 0, top = 0, bottom = 0 }
      overrides.hide_tab_bar_if_only_one_tab = true
      window:set_config_overrides(overrides)
      window:toggle_fullscreen()
    end
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
  { key = 'F11', mods = 'NONE', action = toggle_borderless_fullscreen() },
}
return config
