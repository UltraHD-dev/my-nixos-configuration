-- ============================================
-- Основные переменные
-- ============================================
local mainMod = "SUPER"
local terminal = "kitty"
local launcher = "fuzzel"

-- ============================================
-- Автозапуск
-- ============================================
hl.on("hyprland.start", function()
  hl.exec_cmd("waybar")
  hl.exec_cmd("mako")
  hl.exec_cmd("hyprpolkitagent")
  hl.exec_cmd("swaybg -i ~/Pictures/wallpaper.jpg")
end)

-- ============================================
-- Основные настройки
-- ============================================
hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 15,
    border_size = 2,
    col = {
      active_border = "rgba(5289E2ee) rgba(6897BBee) 45deg",
      inactive_border = "rgba(595959aa)",
    },
    layout = "dwindle",
  },
  decoration = {
    rounding = 12,
    blur = {
      enabled = true,
      size = 8,
      passes = 2,
      new_optimizations = true,
    },
    shadow = {
      enabled = true,
      range = 4,
      color = "rgba(1a1a1aee)",
    },
    -- Прозрачность окон
    active_opacity = 0.95,
    inactive_opacity = 0.85,
    fullscreen_opacity = 1.0,
  },
  input = {
    kb_layout = "us,ru",
    kb_options = "grp:alt_shift_toggle",
    follow_mouse = 1,
    sensitivity = 0,
    touchpad = {
      natural_scroll = true,
      clickfinger_behavior = 1,
    },
  },
  dwindle = {
    pseudotile = true,
    preserve_split = true,
  },
  master = {
    new_status = "master",
  },
  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    force_default_wallpaper = 0,
  },
})

-- ============================================
-- Горячие клавиши
-- ============================================

-- Терминал и лаунчер
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(launcher))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("dolphin"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox"))

-- Управление окнами
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Перемещение фокуса (стрелки)
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Перемещение фокуса (Vim-стиль)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Перемещение активного окна
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Перемещение активного окна (Vim-стиль)
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Изменение размера окна
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -30, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 30, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -30 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 30 }), { repeating = true })

-- Переключение рабочих столов
for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key, hl.dsp.workspace({ workspace = tostring(i) }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = tostring(i) }))
end

-- Переключение рабочих столов (колесо мыши)
hl.bind(mainMod .. " + mouse_down", hl.dsp.workspace({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.workspace({ workspace = "e-1" }))

-- Специальный рабочий стол (scratchpad)
hl.bind(mainMod .. " + TAB", hl.dsp.workspace({ workspace = "special:scratchpad" }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.window.move({ workspace = "special:scratchpad" }))

-- Медиа-клавиши
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true })

-- Скриншоты
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))
hl.bind("PRINT", hl.dsp.exec_cmd("grim - | wl-copy"))

-- Управление сессией
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("wlogout"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exit())

-- ============================================
-- Правила для окон
-- ============================================
hl.window_rule({
  name = "pavucontrol-float",
  match = { class = "^(pavucontrol)$" },
  float = true,
})
hl.window_rule({
  name = "nm-connection-editor-float",
  match = { class = "^(nm-connection-editor)$" },
  float = true,
})
hl.window_rule({
  name = "file-roller-float",
  match = { class = "^(file-roller)$" },
  float = true,
})