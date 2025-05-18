extends Area3D

func _on_body_entered(body):
	if body.name == "Player" and get_node("/root/Global").has_key:
		get_tree().change_scene_to_file("res://scenes/Win.tscn")
