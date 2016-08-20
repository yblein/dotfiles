theme_dir = os.getenv("XDG_CONFIG_HOME") .. "/awesome/theme/"
layouts = "/usr/share/awesome/themes/default/layouts/"

theme = {}

theme.font       = "Snap 8"
theme.icon_theme = nil
theme.wallpaper  = theme_dir .. "arch_minimal_no_circle.svg"

-- Colors
--to trye : bg     = "#262729"
bg     = "#080808"
fg     = "#ffffff"
focus  = "#0fb9db"
border = "#333333"

theme.bg_normal     = bg
theme.bg_focus      = bg
theme.bg_urgent     = focus
theme.bg_minimize   = bg
theme.bg_systray    = bg

theme.fg_normal     = fg
theme.fg_focus      = focus
theme.fg_urgent     = bg
theme.fg_minimize   = fg

theme.border_width  = 1
theme.border_normal = border
theme.border_focus  = focus
theme.border_marked = border

-- Taglist squares
theme.taglist_squares_unsel = theme_dir .. "taglist/squarew.png"

-- Layouts icons
theme.layout_fairh      = layouts .. "fairhw.png"
theme.layout_fairv      = layouts .. "fairvw.png"
theme.layout_floating   = layouts .. "floatingw.png"
theme.layout_magnifier  = layouts .. "magnifierw.png"
theme.layout_max        = layouts .. "maxw.png"
theme.layout_fullscreen = layouts .. "fullscreenw.png"
theme.layout_tilebottom = layouts .. "tilebottomw.png"
theme.layout_tileleft   = layouts .. "tileleftw.png"
theme.layout_tile       = layouts .. "tilew.png"
theme.layout_tiletop    = layouts .. "tiletopw.png"
theme.layout_spiral     = layouts .. "spiralw.png"
theme.layout_dwindle    = layouts .. "dwindlew.png"

-- Tasklist properties
theme.tasklist_sticky               = "[S] "
theme.tasklist_ontop                = "[T] "
theme.tasklist_floating             = "[F] "
theme.tasklist_maximized_horizontal = "[M] "
theme.tasklist_maximized_vertical   = ""

return theme
