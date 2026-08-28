-- swayimg configuration (converted from INI to Lua)

--------------------------------------------------------------------------------
-- General (startup-only settings first)
--------------------------------------------------------------------------------
swayimg.overlay = false
swayimg.decoration = false
swayimg.set_window_size(1280, 720)
swayimg.antialiasing = true

--------------------------------------------------------------------------------
-- Image list
--------------------------------------------------------------------------------
swayimg.imagelist.order = "alpha"
swayimg.imagelist.reverse = false
swayimg.imagelist.recursive = false
swayimg.imagelist.adjacent = false

--------------------------------------------------------------------------------
-- Text / Font
--------------------------------------------------------------------------------
swayimg.text.font = "monospace"
swayimg.text.size = 14
swayimg.text.color = 0xffcccccc
swayimg.text.shadow = 0xd0000000
swayimg.text.background = 0x00000000
swayimg.text.padding = 10
swayimg.text.timeout = 5
swayimg.text.status_timeout = 3
swayimg.text.visible = false

--------------------------------------------------------------------------------
-- Viewer mode
--------------------------------------------------------------------------------
swayimg.viewer.set_window_background(0xff000000)
swayimg.viewer.default_scale = "optimal"
swayimg.viewer.default_position = "center"
swayimg.viewer.loop = true
swayimg.viewer.preload = 10
swayimg.viewer.drag_button = "MouseLeft"

swayimg.viewer.set_text("topleft", {
  "{name}",
  "{format}",
  "{sizehr}",
  "{frame.width}x{frame.height}",
})
swayimg.viewer.set_text("topright", {
  "{list.index}/{list.total}",
})
swayimg.viewer.set_text("bottomleft", {
  "{scale}%",
})

--------------------------------------------------------------------------------
-- Slideshow mode
--------------------------------------------------------------------------------
swayimg.slideshow.timeout = 3
swayimg.slideshow.set_window_background("auto")
swayimg.slideshow.set_image_background(0xff000000)
swayimg.slideshow.default_scale = "fit"
swayimg.slideshow.default_position = "center"

swayimg.slideshow.set_text("bottomright", {
  "{dir}",
})

--------------------------------------------------------------------------------
-- Gallery mode
--------------------------------------------------------------------------------
swayimg.gallery.thumb_size = 200
swayimg.gallery.cache = 100
swayimg.gallery.preload = false
swayimg.gallery.pstore = false
swayimg.gallery.window_color = 0xff000000
swayimg.gallery.unselected_color = 0xff202020
swayimg.gallery.selected_color = 0xff404040
swayimg.gallery.border_size = 4
swayimg.gallery.border_color = 0xffff8800
swayimg.gallery.selected_scale = 1.15

swayimg.gallery.set_text("topright", {
  "{list.index}/{list.total}",
})
swayimg.gallery.set_text("bottomright", {
  "{name}",
})

--------------------------------------------------------------------------------
-- Signal handlers
--------------------------------------------------------------------------------
swayimg.viewer.on_signal("USR1", function()
  -- reload: no direct API equivalent
end)
swayimg.viewer.on_signal("USR2", function()
  swayimg.viewer.open("next")
end)

--------------------------------------------------------------------------------
-- Helper functions
--------------------------------------------------------------------------------
local function viewer_step(dx_pct, dy_pct)
  local wnd = swayimg.get_window_size()
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(
    math.floor(pos.x + wnd.width * dx_pct / 100),
    math.floor(pos.y + wnd.height * dy_pct / 100)
  )
end

local function viewer_zoom(delta_pct)
  local scale = swayimg.viewer.scale
  swayimg.viewer.set_abs_scale(scale + scale * delta_pct / 100)
end

local function viewer_zoom_mouse(delta_pct)
  local mouse = swayimg.get_mouse_pos()
  local scale = swayimg.viewer.scale
  swayimg.viewer.set_abs_scale(scale + scale * delta_pct / 100, mouse.x, mouse.y)
end

local sticky_scale = nil

local function viewer_apply_sticky()
  if sticky_scale then
    swayimg.viewer.set_fix_scale(sticky_scale)
  end
end

local function viewer_switch(dir)
  swayimg.viewer.open(dir)
  viewer_apply_sticky()
end

local function viewer_set_sticky_scale(mode)
  sticky_scale = mode
  swayimg.viewer.set_fix_scale(mode)
end

local function viewer_skip()
  local image = swayimg.viewer.get_image()
  swayimg.viewer.open("next")
  swayimg.imagelist.remove(image.path)
end

local function basename(path)
  return path:match("([^/]+)$") or path
end

local function viewer_trash()
  local image = swayimg.viewer.get_image()
  local name = basename(image.path)
  os.execute("mv '" .. image.path .. "' ~/.local/share/Trash/files && notify-send 'File moved to trash: " .. name .. "'")
  swayimg.viewer.open("next")
  swayimg.imagelist.remove(image.path)
end

local function gallery_trash()
  local image = swayimg.gallery.get_image()
  local name = basename(image.path)
  os.execute("mv '" .. image.path .. "' ~/.local/share/Trash/files && notify-send 'File moved to trash: " .. name .. "'")
  swayimg.imagelist.remove(image.path)
end

--------------------------------------------------------------------------------
-- Viewer key bindings
--------------------------------------------------------------------------------
swayimg.viewer.on_key("f", function() swayimg.fullscreen = not swayimg.fullscreen end)
swayimg.viewer.on_key("j", function() viewer_switch("next") end)
swayimg.viewer.on_key("k", function() viewer_switch("prev") end)
swayimg.viewer.on_key("r", function() swayimg.viewer.rotate(90) end)
swayimg.viewer.on_key("Shift-r", function() swayimg.viewer.rotate(270) end)
swayimg.viewer.on_key("Space", function() viewer_switch("random") end)
swayimg.viewer.on_key("q", function() swayimg.exit() end)
swayimg.viewer.on_key("Shift-Delete", function() viewer_trash() end)
swayimg.viewer.on_key("o", function()
  local image = swayimg.viewer.get_image()
  os.execute('swaymsg exec thunar "' .. image.path .. '"')
end)
swayimg.viewer.on_key("Home", function() viewer_switch("first") end)
swayimg.viewer.on_key("End", function() viewer_switch("last") end)
swayimg.viewer.on_key("Prior", function() viewer_switch("prev") end)
swayimg.viewer.on_key("Next", function() viewer_switch("next") end)
swayimg.viewer.on_key("Shift-d", function() viewer_switch("prev_dir") end)
swayimg.viewer.on_key("d", function() viewer_switch("next_dir") end)
swayimg.viewer.on_key("Shift-o", function()
  local frame = swayimg.viewer.frame
  if frame > 0 then swayimg.viewer.frame = frame - 1 end
end)
swayimg.viewer.on_key("c", function() viewer_skip() end)
swayimg.viewer.on_key("s", function() swayimg.mode = "slideshow" end)
swayimg.viewer.on_key("Tab", function() swayimg.mode = "gallery" end)
swayimg.viewer.on_key("Left", function() viewer_step(10, 0) end)
swayimg.viewer.on_key("Right", function() viewer_step(-10, 0) end)
swayimg.viewer.on_key("Up", function() viewer_step(0, 10) end)
swayimg.viewer.on_key("Down", function() viewer_step(0, -10) end)
swayimg.viewer.on_key("Equal", function() viewer_zoom(10) end)
swayimg.viewer.on_key("Plus", function() viewer_zoom(10) end)
swayimg.viewer.on_key("Minus", function() viewer_zoom(-10) end)
swayimg.viewer.on_key("w", function() swayimg.viewer.set_fix_scale("width") end)
swayimg.viewer.on_key("Shift-w", function() swayimg.viewer.set_fix_scale("height") end)
swayimg.viewer.on_key("a", function() swayimg.viewer.set_fix_scale("fit") end)
swayimg.viewer.on_key("Shift-a", function() viewer_set_sticky_scale("fit") end)
swayimg.viewer.on_key("0", function() swayimg.viewer.set_fix_scale("real") end)
swayimg.viewer.on_key("BackSpace", function() viewer_switch("prev") end)
swayimg.viewer.on_key("bracketleft", function() swayimg.viewer.rotate(270) end)
swayimg.viewer.on_key("bracketright", function() swayimg.viewer.rotate(90) end)
swayimg.viewer.on_key("m", function() swayimg.viewer.flip_vertical() end)
swayimg.viewer.on_key("Shift-m", function() swayimg.viewer.flip_horizontal() end)

-- Mouse bindings (viewer)
swayimg.viewer.on_mouse("ScrollLeft", function() viewer_step(-5, 0) end)
swayimg.viewer.on_mouse("ScrollRight", function() viewer_step(5, 0) end)
swayimg.viewer.on_mouse("ScrollUp", function() viewer_step(0, 5) end)
swayimg.viewer.on_mouse("ScrollDown", function() viewer_step(0, -5) end)
swayimg.viewer.on_mouse("Ctrl-ScrollUp", function() viewer_zoom_mouse(10) end)
swayimg.viewer.on_mouse("Ctrl-ScrollDown", function() viewer_zoom_mouse(-10) end)
swayimg.viewer.on_mouse("Shift-ScrollUp", function() swayimg.viewer.open("prev") end)
swayimg.viewer.on_mouse("Shift-ScrollDown", function() swayimg.viewer.open("next") end)
swayimg.viewer.on_mouse("Alt-ScrollUp", function()
  local frame = swayimg.viewer.frame
  if frame > 0 then swayimg.viewer.frame = frame - 1 end
end)
swayimg.viewer.on_mouse("Alt-ScrollDown", function() swayimg.viewer.frame = swayimg.viewer.frame + 1 end)
swayimg.viewer.on_mouse("MouseSide", function() swayimg.viewer.open("prev") end)
swayimg.viewer.on_mouse("MouseExtra", function() swayimg.viewer.open("next") end)

--------------------------------------------------------------------------------
-- Gallery key bindings
--------------------------------------------------------------------------------
swayimg.gallery.on_key("Tab", function() swayimg.mode = "viewer" end)
swayimg.gallery.on_key("h", function() swayimg.gallery.select("left") end)
swayimg.gallery.on_key("j", function() swayimg.gallery.select("down") end)
swayimg.gallery.on_key("k", function() swayimg.gallery.select("up") end)
swayimg.gallery.on_key("l", function() swayimg.gallery.select("right") end)
swayimg.gallery.on_key("Shift-Delete", function() gallery_trash() end)
swayimg.gallery.on_key("Home", function() swayimg.gallery.select("first") end)
swayimg.gallery.on_key("End", function() swayimg.gallery.select("last") end)
swayimg.gallery.on_key("Left", function() swayimg.gallery.select("left") end)
swayimg.gallery.on_key("Right", function() swayimg.gallery.select("right") end)
swayimg.gallery.on_key("Prior", function() swayimg.gallery.select("pgup") end)
swayimg.gallery.on_key("Next", function() swayimg.gallery.select("pgdown") end)
swayimg.gallery.on_key("c", function()
  local image = swayimg.gallery.get_image()
  swayimg.imagelist.remove(image.path)
end)
swayimg.gallery.on_key("s", function() swayimg.mode = "slideshow" end)
swayimg.gallery.on_key("f", function() swayimg.fullscreen = not swayimg.fullscreen end)
swayimg.gallery.on_key("Equal", function()
  swayimg.gallery.thumb_size = swayimg.gallery.thumb_size + 20
end)
swayimg.gallery.on_key("Plus", function()
  swayimg.gallery.thumb_size = swayimg.gallery.thumb_size + 20
end)
swayimg.gallery.on_key("Minus", function()
  swayimg.gallery.thumb_size = swayimg.gallery.thumb_size - 20
end)
swayimg.gallery.on_key("Escape", function() swayimg.exit() end)
swayimg.gallery.on_key("q", function() swayimg.exit() end)

-- Mouse bindings (gallery)
swayimg.gallery.on_mouse("ScrollLeft", function() swayimg.gallery.select("right") end)
swayimg.gallery.on_mouse("ScrollRight", function() swayimg.gallery.select("left") end)
swayimg.gallery.on_mouse("ScrollUp", function() swayimg.gallery.select("up") end)
swayimg.gallery.on_mouse("ScrollDown", function() swayimg.gallery.select("down") end)
swayimg.gallery.on_mouse("Ctrl-ScrollUp", function()
  swayimg.gallery.thumb_size = swayimg.gallery.thumb_size + 20
end)
swayimg.gallery.on_mouse("Ctrl-ScrollDown", function()
  swayimg.gallery.thumb_size = swayimg.gallery.thumb_size - 20
end)
swayimg.gallery.on_mouse("MouseLeft", function() swayimg.mode = "viewer" end)

--------------------------------------------------------------------------------
-- Slideshow key bindings
--------------------------------------------------------------------------------
swayimg.slideshow.on_key("Home", function() swayimg.slideshow.open("first") end)
swayimg.slideshow.on_key("End", function() swayimg.slideshow.open("last") end)
swayimg.slideshow.on_key("Prior", function() swayimg.slideshow.open("prev") end)
swayimg.slideshow.on_key("Next", function() swayimg.slideshow.open("next") end)
swayimg.slideshow.on_key("Shift-r", function() swayimg.slideshow.open("random") end)
swayimg.slideshow.on_key("Shift-d", function() swayimg.slideshow.open("prev_dir") end)
swayimg.slideshow.on_key("d", function() swayimg.slideshow.open("next_dir") end)
swayimg.slideshow.on_key("f", function() swayimg.fullscreen = not swayimg.fullscreen end)
swayimg.slideshow.on_key("Return", function() swayimg.mode = "viewer" end)
swayimg.slideshow.on_key("Escape", function() swayimg.exit() end)
swayimg.slideshow.on_key("q", function() swayimg.exit() end)
