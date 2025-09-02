extends Control
# Put this script on a parent UI node (e.g., a full-screen Control/CanvasLayer root),
# and make the TextureProgressBar a child named "Bar".

@onready var bar: TextureProgressBar = $Bar
var follow := true
var offset := Vector2(12, 16)  # shift so it doesn't sit directly on the cursor

func _ready() -> void:
	bar.min_value = 0
	bar.max_value = 100
	bar.value = 75

func _process(_delta: float) -> void:
	if not follow:
		return

	# Mouse in viewport (screen) coordinates
	var mouse_screen: Vector2 = get_viewport().get_mouse_position()

	# Convert to this Control's local space (important if this Control is nested/scaled)
	bar.position = bar.get_parent().get_local_mouse_position()
	
	bar.position.x -= 20
	bar.position.y -= 20
