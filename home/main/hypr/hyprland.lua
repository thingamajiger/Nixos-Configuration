-- ==========================================
-- HYPRLAND CONFIG
-- Hyprland 0.56.1
-- ==========================================


-- ==========================================
-- MONITORS
-- ==========================================

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

hl.monitor({
    output = "DP-2",
    mode = "2560x1440@165",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "1680x1050@60",
    position = "-1680x0",
    scale = 1,
})


-- ==========================================
-- ENVIRONMENT
-- ==========================================

hl.env("XCURSOR_THEME", "Banana")
hl.env("XCURSOR_SIZE", "32")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")


-- ==========================================
-- AUTOSTART
-- ==========================================

hl.on("hyprland.start", function()
    hl.exec_cmd("easyeffects --gapplication-service")
    hl.exec_cmd("bash -c 'sleep 3 && waybar'")
    hl.exec_cmd("dunst")
    hl.exec_cmd("thunar --daemon")
    hl.exec_cmd("~/bin/dock-fullscreen.sh")

    -- hyprpaper intentionally disabled

    hl.exec_cmd("mkdir -p ~/.cache/awww")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("sleep 2 && awww img /home/tmajig/Pictures/Wallpapers/abandoned.jpg")
    hl.exec_cmd("nm-applet --indicator")
end)


-- ==========================================
-- INPUT
-- ==========================================

hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,
        accel_profile = flat,
 
        touchpad = {
            natural_scroll = false,
        },
    },
})


-- ==========================================
-- GENERAL
-- ==========================================

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,

        border_size = 2,

col = {
    active_border = {
        colors = {
            "rgba(151D24ff)",
            "rgba(344854ff)",
            "rgba(718A9Aff)",
            "rgba(DCE5EAff)",
            "rgba(718A9Aff)",
            "rgba(344854ff)",
        },
        angle = 45,
    },

    inactive_border = {
        colors = {
            "rgba(151D24ff)",
            "rgba(344854ff)",
            "rgba(718A9Aff)",
            "rgba(DCE5EAff)",
            "rgba(718A9Aff)",
            "rgba(344854ff)",
        },
        angle = 45,
    },
},

        resize_on_border = true,
        allow_tearing = false,

        layout = "dwindle",
    },
})

-- ==========================================
-- DECORATION
-- ==========================================

hl.config({
    decoration = {
        rounding = 8,

        blur = {
            enabled = true,
            size = 3,
            passes = 2,
            noise = 0.02,
        },
    },
})


-- ==========================================
-- MISC
-- ==========================================

hl.config({
    misc = {
        vrr = 1,
    },
})


-- ==========================================
-- ANIMATIONS
-- ==========================================

hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve("workspace_fast", {
    type = "bezier",
    points = {
        { 0.25, 0.9 },
        { 0.4, 1.0 },
    },
})

hl.curve("linear", {
    type = "bezier",
    points = {
        { 1.0, 1.0 },
        { 1.0, 1.0 },
    },
})

hl.curve("spring", {
    type = "spring",
    stiffness = 250,
    dampening = 25,
    mass = 1,
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 3,
    bezier = "workspace_fast",
    style = "slidefadevert",
})

hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 5,
    spring = "spring",
    style = "popin",
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 5,
    spring = "spring",
    style = "popin",
})

hl.animation({
    leaf = "borderangle",
    enabled = true,
    speed = 100,
    bezier = "linear",
    style = "loop",
})

hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 4,
    spring = "spring",
    style = "slide",
})

-- ==========================================
-- DWINDLE
-- ==========================================

hl.config({
    dwindle = {
        preserve_split = true,
    },
})


-- ==========================================
-- KEYBINDS
-- ==========================================

local mainMod = "SUPER"


-- Audio

hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86AudioNext",
    hl.dsp.exec_cmd("playerctl next")
)

hl.bind(
    "XF86AudioPrev",
    hl.dsp.exec_cmd("playerctl previous")
)


-- Applications

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty"))

hl.bind(
    mainMod .. " + S",
    hl.dsp.exec_cmd("spotify-launcher")
)

hl.bind(
    mainMod .. " + D",
    hl.dsp.exec_cmd("~/.config/rofi/launchers/type-3/launcher.sh")
)

hl.bind(
    mainMod .. " + B",
    hl.dsp.exec_cmd("flatpak run app.zen_browser.zen")
)

hl.bind(
    mainMod .. " + X",
    hl.dsp.exec_cmd("pwvucontrol")
)

hl.bind(
    mainMod .. " + E",
    hl.dsp.exec_cmd("thunar")
)


-- Hyprland controls

hl.bind(
    mainMod .. " + R",
    hl.dsp.exec_cmd("hyprctl reload")
)

hl.bind(
    mainMod .. " + Q",
    hl.dsp.window.close()
)

hl.bind(
    mainMod .. " + M",
    hl.dsp.exit()
)

hl.bind(
    mainMod .. " + F",
    hl.dsp.window.fullscreen()
)

hl.bind(
    mainMod .. " + V",
    hl.dsp.window.float({ action = "toggle" })
)


-- Workspace switching

for i = 1, 7 do
    -- Switch to workspace
    hl.bind(
        mainMod .. " + " .. i,
        hl.dsp.focus({ workspace = i })
    )

    -- Move current window to workspace
    hl.bind(
        mainMod .. " + SHIFT + " .. i,
        hl.dsp.window.move({ workspace = i })
    )
end

hl.bind("SUPER + Z", function()
    hl.plugin.hyprexpo.expo("toggle")
end)

-- Focus movement

hl.bind(
    mainMod .. " + left",
    hl.dsp.focus({ direction = "left" })
)

hl.bind(
    mainMod .. " + right",
    hl.dsp.focus({ direction = "right" })
)

hl.bind(
    mainMod .. " + up",
    hl.dsp.focus({ direction = "up" })
)

hl.bind(
    mainMod .. " + down",
    hl.dsp.focus({ direction = "down" })
)


-- Mouse window movement / resizing

hl.bind(
    mainMod .. " + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true }
)

hl.bind(
    mainMod .. " + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true }
)


-- Screenshots

hl.bind(
    mainMod .. " + Home",
    hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots")
)

hl.bind(
    mainMod .. " + End",
    hl.dsp.exec_cmd("hyprshot -m window -o ~/Pictures/Screenshots")
)

hl.bind(
    mainMod .. " + Page_Down",
    hl.dsp.exec_cmd("hyprshot -m output -o ~/Pictures/Screenshots")
)


-- Scripts

hl.bind(
    "F6",
    hl.dsp.exec_cmd("~/.config/hypr/autoclick.sh")
)

hl.bind(
    "SHIFT + F6",
    hl.dsp.exec_cmd("~/bob-loop.sh")
)


-- ==========================================
-- WINDOW RULES
-- ==========================================

-- XWayland video bridge

hl.window_rule({
    name = "xwayland-video-bridge-fixes",

    match = {
        class = "xwaylandvideobridge",
    },

    no_initial_focus = true,
    no_focus = true,
    no_anim = true,
    no_blur = true,

    max_size = "1 1",

    opacity = 0.0,
})


-- ==========================================
-- LAYER RULES
-- ==========================================

hl.layer_rule({
    name = "quickshell-animation",
    match = {
        namespace = "^(quickshell.*)$",
    },

    animation = "popin",
})

hl.layer_rule({
    name = "quickshell-blur",
    match = {
        namespace = "^(quickshell.*)$",
    },

    blur = true,
})

hl.layer_rule({
    name = "quickshell-ignore-alpha",
    match = {
        namespace = "^(quickshell.*)$",
    },

    ignore_alpha = 0.3,
})


-- ==========================================
-- BLURLS
-- ==========================================
