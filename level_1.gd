# actually centre the camera ?




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

#╰(*°▽°*)╯works now, the problem - ray was hitting staticbody3d and the on cube clicked logic was on other node
# this works for some reason??? after adding the player ??
# on cube clicked does not work tho




func _process(delta: float) -> void:
	pass
