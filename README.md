# This on Godot 3.6.2 (Godot 3.5)

to change the `Resolution Render` not just window size to **work in windowed and full screen mode** and affect on the **performance** and **fps**:

for example you can use `get_tree().root.set_size(OS.window_size * 0.5)` this will change the resolution render the screen more pixelated and more performance and you can change the value any float number.

**no resolution change** in windowed mode:

<img width="1024" height="602" alt="image" src="https://github.com/user-attachments/assets/f99ea356-e0ea-48a9-8ee1-d0ebf4d05983" />


**no resolution change** in full screen mode:

<img width="1280" height="1024" alt="image" src="https://github.com/user-attachments/assets/e5d62dac-925d-4a40-bb6e-081a4f5ec30c" />


with this code:

<img width="304" height="86" alt="image" src="https://github.com/user-attachments/assets/67bd2b13-5ed6-4454-98dc-05b54da5aa7f" />


**resolution change** in windowed mode:

<img width="1027" height="606" alt="image" src="https://github.com/user-attachments/assets/d8076a79-f744-481b-bf1b-87b4223b9549" />


**resolution change** in full screen mode:

<img width="1277" height="1024" alt="image" src="https://github.com/user-attachments/assets/274d8a1f-0e8c-41ea-a11f-1c3658476d6c" />


full code:

```
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
```

**with this code you can press ‘Home button’ to change resolution between half and normal and press ‘Page Up button’ to change between full screen and windowed.**

note: can change the controls :)

i hope this helpful and take the root of code and change it to what you want.
