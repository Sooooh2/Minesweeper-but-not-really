# box.gd
extends StaticBody3D

var grid_pos: Vector2i  # Declare this to avoid assignment errors

func on_cube_clicked():
	print(" Cube clicked at: ", grid_pos)
