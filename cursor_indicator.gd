extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation = "valid"
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = get_global_mouse_position().snapped(Vector2(50, 50))
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
