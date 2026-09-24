hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 20,
    border_size = 2,
    col = {
      active_border = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },
    layout = "dwindle",
  },
  decoration = {
    rounding = 10,
    blur = { enabled = true, size = 3, passes = 1 },
  },
  input = {
    kb_layout = "us,ru",
    kb_options = "grp:caps_toggle",
    follow_mouse = 1,
  },
})