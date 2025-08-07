

extends Node3D
@onready var box: StaticBody3D = $box

@onready var player: CharacterBody3D = $player

var grid_s = 5
var cube_s = 1.5
var grid = []

func _ready() -> void:
	
	
# maing the level grid of cubes
	for x in range(grid_s):
		var row = []
		for y in range(grid_s):
			var cube = box.duplicate()
			cube.set_script(preload("res://cube/box.gd"))
			cube.position = Vector3(x * cube_s, 0, y * cube_s)
			cube.grid_pos = Vector2i(x,y)
			add_child(cube)
			row.append(cube)
		grid.append(row)
	



func _unhandled_input(event: InputEvent) -> void:
# raycasting to move the player through clicks
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var camera = get_viewport().get_camera_3d()
		var from = camera.project_ray_origin(event.position)
		var to = from + camera.project_ray_normal(event.position) * 100
		var query = PhysicsRayQueryParameters3D.create(from, to)

		var space_state = get_world_3d().direct_space_state
		var result = space_state.intersect_ray(query)
		if result:
			print("Has method on_cube_clicked? ", result.collider.has_method("on_cube_clicked"))

			if result.collider.has_method("on_cube_clicked"):
				result.collider.on_cube_clicked()

func _camera_move():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		pass;

func _player_move_to(t_pos: Vector3):
	var jump_h = 1.0
	var jump_time = 0.5

	var start_pos = player.global_position
	var end_pos = t_pos

	var tween = get_tree().create_tween()
	tween.tween_property(player,"global_position",end_pos +Vector3(0, jump_h,0), jump_time * 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(player,"global_position",end_pos, jump_time * 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)



	
	
	
func _process(delta: float) -> void:
	pass
