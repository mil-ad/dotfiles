-- swayimg configuration (converted from INI to Lua)

--------------------------------------------------------------------------------
-- General (startup-only settings first)
--------------------------------------------------------------------------------
swayimg.enable_overlay(false)
swayimg.enable_decoration(false)
swayimg.set_window_size(1280, 720)
swayimg.enable_antialiasing(true)

--------------------------------------------------------------------------------
-- Image list
--------------------------------------------------------------------------------
swayimg.imagelist.set_order("alpha")
swayimg.imagelist.enable_reverse(false)
swayimg.imagelist.enable_recursive(false)
swayimg.imagelist.enable_adjacent(false)

--------------------------------------------------------------------------------
-- Text / Font
--------------------------------------------------------------------------------
swayimg.text.set_font("monospace")
swayimg.text.set_size(14)
swayimg.text.set_foreground(0xffcccccc)
swayimg.text.set_shadow(0xd0000000)
swayimg.text.set_background(0x00000000)
swayimg.text.set_padding(10)
swayimg.text.set_timeout(5)
swayimg.text.set_status_timeout(3)
swayimg.text.hide()

--------------------------------------------------------------------------------
-- Viewer mode
--------------------------------------------------------------------------------
swayimg.viewer.set_window_background(0xff000000)
swayimg.viewer.set_default_scale("optimal")
swayimg.viewer.set_default_position("center")
swayimg.viewer.enable_loop(true)
swayimg.viewer.limit_preload(10)
swayimg.viewer.set_drag_button("MouseLeft")

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
swayimg.slideshow.set_timeout(3)
swayimg.slideshow.set_window_background("auto")
swayimg.slideshow.set_image_background(0xff000000)
swayimg.slideshow.set_default_scale("fit")
swayimg.slideshow.set_default_position("center")

swayimg.slideshow.set_text("bottomright", {
  "{dir}",
})

--------------------------------------------------------------------------------
-- Gallery mode
--------------------------------------------------------------------------------
swayimg.gallery.set_thumb_size(200)
swayimg.gallery.limit_cache(100)
swayimg.gallery.enable_preload(false)
swayimg.gallery.enable_pstore(false)
swayimg.gallery.set_window_color(0xff000000)
swayimg.gallery.set_unselected_color(0xff202020)
swayimg.gallery.set_selected_color(0xff404040)

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
  swayimg.viewer.switch_image("next")
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
  local scale = swayimg.viewer.get_scale()
  swayimg.viewer.set_abs_scale(scale + scale * delta_pct / 100)
end

local function viewer_zoom_mouse(delta_pct)
  local mouse = swayimg.get_mouse_pos()
  local scale = swayimg.viewer.get_scale()
  swayimg.viewer.set_abs_scale(scale + scale * delta_pct / 100, mouse.x, mouse.y)
end

local function viewer_skip()
  local image = swayimg.viewer.get_image()
  swayimg.viewer.switch_image("next")
  swayimg.imagelist.remove(image.path)
end

local function basename(path)
  return path:match("([^/]+)$") or path
end

local function viewer_trash()
  local image = swayimg.viewer.get_image()
  local name = basename(image.path)
  os.execute("mv '" .. image.path .. "' ~/.local/share/Trash/files && notify-send 'File moved to trash: " .. name .. "'")
  swayimg.viewer.switch_image("next")
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
swayimg.viewer.on_key("f", function() swayimg.toggle_fullscreen() end)
swayimg.viewer.on_key("j", function() swayimg.viewer.switch_image("next") end)
swayimg.viewer.on_key("k", function() swayimg.viewer.switch_image("prev") end)
swayimg.viewer.on_key("r", function() swayimg.viewer.rotate(90) end)
swayimg.viewer.on_key("Shift-r", function() swayimg.viewer.rotate(270) end)
swayimg.viewer.on_key("Space", function() swayimg.viewer.switch_image("random") end)
swayimg.viewer.on_key("q", function() swayimg.exit() end)
swayimg.viewer.on_key("Shift-Delete", function() viewer_trash() end)
swayimg.viewer.on_key("o", function()
  local image = swayimg.viewer.get_image()
  os.execute('swaymsg exec thunar "' .. image.path .. '"')
end)
swayimg.viewer.on_key("Home", function() swayimg.viewer.switch_image("first") end)
swayimg.viewer.on_key("End", function() swayimg.viewer.switch_image("last") end)
swayimg.viewer.on_key("Prior", function() swayimg.viewer.switch_image("prev") end)
swayimg.viewer.on_key("Next", function() swayimg.viewer.switch_image("next") end)
swayimg.viewer.on_key("Shift-d", function() swayimg.viewer.switch_image("prev_dir") end)
swayimg.viewer.on_key("d", function() swayimg.viewer.switch_image("next_dir") end)
swayimg.viewer.on_key("Shift-o", function() swayimg.viewer.prev_frame() end)
swayimg.viewer.on_key("c", function() viewer_skip() end)
swayimg.viewer.on_key("s", function() swayimg.set_mode("slideshow") end)
swayimg.viewer.on_key("Tab", function() swayimg.set_mode("gallery") end)
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
swayimg.viewer.on_key("Shift-a", function() swayimg.viewer.set_fix_scale("fill") end)
swayimg.viewer.on_key("0", function() swayimg.viewer.set_fix_scale("real") end)
swayimg.viewer.on_key("BackSpace", function() swayimg.viewer.switch_image("prev") end)
swayimg.viewer.on_key("bracketleft", function() swayimg.viewer.rotate(270) end)
swayimg.viewer.on_key("bracketright", function() swayimg.viewer.rotate(90) end)
-- m = flip_vertical, Shift-m = flip_horizontal: no Lua API equivalent

-- Mouse bindings (viewer)
swayimg.viewer.on_mouse("ScrollLeft", function() viewer_step(-5, 0) end)
swayimg.viewer.on_mouse("ScrollRight", function() viewer_step(5, 0) end)
swayimg.viewer.on_mouse("ScrollUp", function() viewer_step(0, 5) end)
swayimg.viewer.on_mouse("ScrollDown", function() viewer_step(0, -5) end)
swayimg.viewer.on_mouse("Ctrl-ScrollUp", function() viewer_zoom_mouse(10) end)
swayimg.viewer.on_mouse("Ctrl-ScrollDown", function() viewer_zoom_mouse(-10) end)
swayimg.viewer.on_mouse("Shift-ScrollUp", function() swayimg.viewer.switch_image("prev") end)
swayimg.viewer.on_mouse("Shift-ScrollDown", function() swayimg.viewer.switch_image("next") end)
swayimg.viewer.on_mouse("Alt-ScrollUp", function() swayimg.viewer.prev_frame() end)
swayimg.viewer.on_mouse("Alt-ScrollDown", function() swayimg.viewer.next_frame() end)
swayimg.viewer.on_mouse("MouseSide", function() swayimg.viewer.switch_image("prev") end)
swayimg.viewer.on_mouse("MouseExtra", function() swayimg.viewer.switch_image("next") end)

--------------------------------------------------------------------------------
-- Gallery key bindings
--------------------------------------------------------------------------------
swayimg.gallery.on_key("Tab", function() swayimg.set_mode("viewer") end)
swayimg.gallery.on_key("h", function() swayimg.gallery.switch_image("left") end)
swayimg.gallery.on_key("j", function() swayimg.gallery.switch_image("down") end)
swayimg.gallery.on_key("k", function() swayimg.gallery.switch_image("up") end)
swayimg.gallery.on_key("l", function() swayimg.gallery.switch_image("right") end)
swayimg.gallery.on_key("Shift-Delete", function() gallery_trash() end)
swayimg.gallery.on_key("Home", function() swayimg.gallery.switch_image("first") end)
swayimg.gallery.on_key("End", function() swayimg.gallery.switch_image("last") end)
swayimg.gallery.on_key("Left", function() swayimg.gallery.switch_image("left") end)
swayimg.gallery.on_key("Right", function() swayimg.gallery.switch_image("right") end)
swayimg.gallery.on_key("Prior", function() swayimg.gallery.switch_image("pgup") end)
swayimg.gallery.on_key("Next", function() swayimg.gallery.switch_image("pgdown") end)
swayimg.gallery.on_key("c", function()
  local image = swayimg.gallery.get_image()
  swayimg.imagelist.remove(image.path)
end)
swayimg.gallery.on_key("s", function() swayimg.set_mode("slideshow") end)
swayimg.gallery.on_key("f", function() swayimg.toggle_fullscreen() end)
swayimg.gallery.on_key("Equal", function()
  swayimg.gallery.set_thumb_size(swayimg.gallery.get_thumb_size() + 20)
end)
swayimg.gallery.on_key("Plus", function()
  swayimg.gallery.set_thumb_size(swayimg.gallery.get_thumb_size() + 20)
end)
swayimg.gallery.on_key("Minus", function()
  swayimg.gallery.set_thumb_size(swayimg.gallery.get_thumb_size() - 20)
end)
swayimg.gallery.on_key("Escape", function() swayimg.exit() end)
swayimg.gallery.on_key("q", function() swayimg.exit() end)

-- Mouse bindings (gallery)
swayimg.gallery.on_mouse("ScrollLeft", function() swayimg.gallery.switch_image("right") end)
swayimg.gallery.on_mouse("ScrollRight", function() swayimg.gallery.switch_image("left") end)
swayimg.gallery.on_mouse("ScrollUp", function() swayimg.gallery.switch_image("up") end)
swayimg.gallery.on_mouse("ScrollDown", function() swayimg.gallery.switch_image("down") end)
swayimg.gallery.on_mouse("Ctrl-ScrollUp", function()
  swayimg.gallery.set_thumb_size(swayimg.gallery.get_thumb_size() + 20)
end)
swayimg.gallery.on_mouse("Ctrl-ScrollDown", function()
  swayimg.gallery.set_thumb_size(swayimg.gallery.get_thumb_size() - 20)
end)
swayimg.gallery.on_mouse("MouseLeft", function() swayimg.set_mode("viewer") end)

--------------------------------------------------------------------------------
-- Slideshow key bindings
--------------------------------------------------------------------------------
swayimg.slideshow.on_key("Home", function() swayimg.slideshow.switch_image("first") end)
swayimg.slideshow.on_key("End", function() swayimg.slideshow.switch_image("last") end)
swayimg.slideshow.on_key("Prior", function() swayimg.slideshow.switch_image("prev") end)
swayimg.slideshow.on_key("Next", function() swayimg.slideshow.switch_image("next") end)
swayimg.slideshow.on_key("Shift-r", function() swayimg.slideshow.switch_image("random") end)
swayimg.slideshow.on_key("Shift-d", function() swayimg.slideshow.switch_image("prev_dir") end)
swayimg.slideshow.on_key("d", function() swayimg.slideshow.switch_image("next_dir") end)
swayimg.slideshow.on_key("f", function() swayimg.toggle_fullscreen() end)
swayimg.slideshow.on_key("Return", function() swayimg.set_mode("viewer") end)
swayimg.slideshow.on_key("Escape", function() swayimg.exit() end)
swayimg.slideshow.on_key("q", function() swayimg.exit() end)
