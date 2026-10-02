i think i know how to do this. to change the `Resolution Render` not just window size to work in windowed and full screen mode and affect on the performance and fps:

for you can use `get_tree().root.set_size(OS.window_size * 0.5)` this will change the resolution render the screen more pixelated and more performance and you can change the value between `0.1-1.0` for example on this code.

this no resolution change in windowed mode:



and this no resolution change in full screen mode:



with this code:



windowed mode:



full screen mode:



full code:

`

extends Spatial

var enable: bool = false
var enable_f: bool = false

func _ready():
	var root = get_tree().root
	var window_size = OS.window_size
	root.set_size(window_size * 0.5)

func _unhandled_input(event):
	if event.is_action_pressed("ui_home"):
	print("press")
	enable = !enable
	
	var root = get_tree().root
	var window_size = OS.window_size
	
	if enable:
		print("enabled")
		root.set_size(window_size * 0.5)
	else:
		print("disabled")
		root.set_size(window_size)
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT, SceneTree.STRETCH_ASPECT_KEEP, root.size)

if event.is_action_pressed("ui_page_up"):
	enable_f = !enable_f
	OS.window_fullscreen = enable_f

func _process(delta):
	print(Performance.get_monitor(Performance.TIME_FPS))

`

with this code you can press ‘Home button’ to change resolution between half and normal and press ‘Page Up button’ to change between full screen and windowed.

note: can change the control 

i hope this helpful and take the root of code and change it to what you want.
