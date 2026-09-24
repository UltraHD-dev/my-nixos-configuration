-- ============================================
-- Монитор
-- ============================================
hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1 })

-- ============================================
-- Курсор
-- ============================================
hl.env("XCURSOR_THEME", "Simplify-Dot-2-Light")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Simplify-Dot-2-Light")
hl.env("HYPRCURSOR_SIZE", "24")

-- ============================================
-- Кривые для мягких анимаций
-- ============================================
hl.curve("soft", { type = "bezier", points = { {0.25, 0.1}, {0.25, 1.0} } })
hl.curve("smooth", { type = "bezier", points = { {0.4, 0.0}, {0.2, 1.0} } })
hl.curve("snappy", { type = "spring", mass = 1, stiffness = 200, dampening = 25 })

-- ============================================
-- Эффект стекла
-- ============================================
hl.config({

  device = {
  {
    name = "htix5288:00-0911:5288",
    enabled = false,  -- 👈 отключаем event8 (мышиная часть)
  },
  {
    name = "htix5288:00-0911:5288-1",
    enabled = true,   -- 👈 оставляем event9 (тачпад)
  },
},

  general = {
    gaps_in = 4,
    gaps_out = 12,
    border_size = 2,
    col = {
      active_border = { colors = {"rgba(255, 255, 255, 0.3)", "rgba(255, 255, 255, 0.1)"}, angle = 45 },
      inactive_border = "rgba(255, 255, 255, 0.05)",
    },
    layout = "dwindle",
    resize_on_border = true,
  },
  decoration = {
    rounding = 14,
    active_opacity = 0.9,
    inactive_opacity = 0.8,
    fullscreen_opacity = 1.0,
    blur = {
      enabled = true,
      size = 10,
      passes = 3,
      new_optimizations = true,
      xray = true,
      noise = 0.015,
      contrast = 1.2,
      brightness = 1.1,
      vibrancy = 0.2,
    },
    shadow = {
      enabled = true,
      range = 12,
      render_power = 3,
      color = "rgba(0, 0, 0, 0.4)",
      color_inactive = "rgba(0, 0, 0, 0.2)",
    },
  },
  input = {
    kb_layout = "us,ru",
    kb_options = "grp:caps_toggle",
    follow_mouse = 1,
    touchpad = {
      natural_scroll = true,
      clickfinger_behavior = 1,
      drag_3fg = 1,
    },
  },
  master = {
    new_status = "master",
    mfact = 0.55,
  },
  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    force_default_wallpaper = 0,
    focus_on_activate = true,
  },
})

-- ============================================
-- Scratchpad-терминал: плавающий Kitty по центру
-- ============================================
hl.window_rule({
  name = "floating-kitty-scratchpad",
  match = { class = "^(kitty-scratchpad)$" },
  float = true,
  size = { "60%", "50%" },
  center = true,
  opacity = "0.95 0.9",
})

-- ============================================
-- Анимации (мягкие, но не медленные)
-- ============================================
hl.animation({ leaf = "windows",    enabled = true, speed = 5, bezier = "smooth", style = "popin 85%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "smooth", style = "popin 85%" })
hl.animation({ leaf = "fade",       enabled = true, speed = 5, bezier = "soft" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "soft", style = "slidefade 15%" })
hl.animation({ leaf = "layers",     enabled = true, speed = 4, bezier = "soft" })
hl.animation({ leaf = "border",     enabled = true, speed = 5, bezier = "soft" })

-- ============================================
-- Автозапуск
-- ============================================
hl.on("hyprland.start", function()
  hl.exec_cmd("noctalia-shell")
  hl.exec_cmd("awww-daemon")
end)
hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'Simplify-Dot-2-Light'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 24")

-- ============================================
-- Бинды
-- ============================================
local mainMod = "SUPER"

-- ─────────────────────────────────────────
-- Запуск приложений
-- ─────────────────────────────────────────
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))                              -- терминал
hl.bind(mainMod .. " + Space",  hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))  -- лаунчер
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd("firefox"))                             -- браузер
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd("dolphin"))                             -- проводник
hl.bind(mainMod .. " + C",      hl.dsp.exec_cmd("code"))                                -- VS Code
hl.bind(mainMod .. " + T",      hl.dsp.exec_cmd("telegram-desktop"))                    -- Telegram
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))      -- буфер обмена
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center")) -- уведомления
hl.bind(mainMod .. " + Grave", hl.dsp.exec_cmd("kitty --class kitty-scratchpad"))       -- Scratchpad-terminal

-- ─────────────────────────────────────────
-- Управление окнами
-- ─────────────────────────────────────────
hl.bind(mainMod .. " + W", hl.dsp.window.close())                                                      -- закрыть
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))                           -- fullscreen
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle", mode = "maximized" })) -- максимайз
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))                                -- float
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())                                                    -- псевдо
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))                                              -- сменить split

-- ─────────────────────────────────────────
-- Управление окнами
-- ─────────────────────────────────────────
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("scratchpad"))            -- показать/скрыть
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:scratchpad" }))  -- отправить окно туда
-- ─────────────────────────────────────────
-- Навигация по окнам (Vim-стиль)
-- ─────────────────────────────────────────
hl.bind(mainMod .. " + CTRL + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.focus({ direction = "down" }))

-- ─────────────────────────────────────────
-- Мышь: перемещение и ресайз окон
-- ─────────────────────────────────────────
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true }) 
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) 

-- ─────────────────────────────────────────
-- Перемещение плавающих окон (Alt + стрелки)
-- ─────────────────────────────────────────
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.move({ x = -20, y = 0, relative = 1 }), { repeating = true })
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.move({ x =  20, y = 0, relative = 1 }), { repeating = true })
hl.bind(mainMod .. " + ALT + up",    hl.dsp.window.move({ x = 0, y = -20, relative = 1 }), { repeating = true })
hl.bind(mainMod .. " + ALT + down",  hl.dsp.window.move({ x = 0, y =  20, relative = 1 }), { repeating = true })

-- ─────────────────────────────────────────
-- Перемещение окон (Vim-стиль, Shift)
-- ─────────────────────────────────────────
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- ─────────────────────────────────────────
-- Перемещение плавающих окон (Shift + Alt + стрелки)
-- ─────────────────────────────────────────
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.move({ x = -20, y = 0, relative = 1 }), { repeating = true })
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.move({ x =  20, y = 0, relative = 1 }), { repeating = true })
hl.bind(mainMod .. " + ALT + up",    hl.dsp.window.move({ x = 0, y = -20, relative = 1 }), { repeating = true })
hl.bind(mainMod .. " + ALT + down",  hl.dsp.window.move({ x = 0, y =  20, relative = 1 }), { repeating = true })

-- ─────────────────────────────────────────
-- Изменение размера (Ctrl + стрелки)
-- ─────────────────────────────────────────
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.resize({ x = -50, y = 0, relative = 1 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x =  50, y = 0, relative = 1 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.resize({ x = 0, y = -50, relative = 1 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.resize({ x = 0, y =  50, relative = 1 }), { repeating = true })

-- ─────────────────────────────────────────
-- Рабочие столы
-- ─────────────────────────────────────────
for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = tostring(i) }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = tostring(i) }))
end

-- ─────────────────────────────────────────
-- Панели Noctalia
-- ─────────────────────────────────────────
hl.bind(mainMod .. " + Tab",       hl.dsp.exec_cmd("noctalia msg window-switcher"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("noctalia msg panel-toggle session"))
hl.bind(mainMod .. " + L",         hl.dsp.exec_cmd("noctalia msg session lock"))   -- блокировка Noctalia

-- ─────────────────────────────────────────
-- Скриншоты
-- ─────────────────────────────────────────
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))
hl.bind("Print",               hl.dsp.exec_cmd("grim - | wl-copy"))
-- ─────────────────────────────────────────
-- Выход
-- ─────────────────────────────────────────
hl.bind(mainMod .. " + M", hl.dsp.exit())

-- ============================================
-- Blur для слоёв Noctalia
-- ============================================
hl.layer_rule({
  name = "blur-noctalia-bar",
  match = { namespace = "noctalia-bar" },
  blur = true,
  ignore_alpha = 0.5,
})

hl.layer_rule({
  name = "blur-noctalia-launcher",
  match = { namespace = "noctalia-launcher" },
  blur = true,
  ignore_alpha = 0.5,
})

-- Размытие для fuzzel (лаунчер)
hl.layer_rule({
  name = "blur-fuzzel",
  match = { namespace = "launcher" },
  blur = true,
  ignore_alpha = 0.5,
})

