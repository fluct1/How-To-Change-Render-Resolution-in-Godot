extends Spatial

var enable: bool = true
var enable_f: bool = false

func _ready():
	if enable:
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
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT, SceneTree.STRETCH_ASPECT_EXPAND, root.size)

	if event.is_action_pressed("ui_page_up"):
		enable_f = !enable_f
		OS.window_fullscreen = enable_f

func _process(delta):
	print(Performance.get_monitor(Performance.TIME_FPS))
