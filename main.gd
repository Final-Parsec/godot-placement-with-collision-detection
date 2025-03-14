extends Node2D

@export var house_scene: PackedScene

var can_build = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$InvalidPlacementMessage.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_released("place_house") && can_build:
		var house = house_scene.instantiate()
		house.position = get_global_mouse_position().snapped(Vector2(50, 50))
		$HouseContainer.add_child(house)
		
	if event.is_action_released("place_house") && !can_build:
		$InvalidPlacementMessage.visible = true
		$HideInvalidPlacementMessage.start()
		
func _physics_process(delta: float) -> void:
	var world_space = get_world_2d().direct_space_state
	var params = PhysicsShapeQueryParameters2D.new()
	params.collide_with_areas = true
	params.collide_with_bodies = true
	params.shape = RectangleShape2D.new()
	params.shape.size = Vector2(89, 76)
	params.transform = Transform2D(0, $CursorIndicator.global_position)
	var collision = world_space.collide_shape(params, 1)
	if collision.is_empty():
		can_build = true
		$CursorIndicator.animation = "valid"
	else:
		can_build = false
		$CursorIndicator.animation = "invalid"


func _on_hide_invalid_placement_message_timeout() -> void:
	$InvalidPlacementMessage.visible = false
