extends StaticBody3D

var grid_pos: Vector2i  # already set in the main script

func on_cube_clicked():
	var main = get_tree().get_current_scene()
	main.move_player_to(position)
