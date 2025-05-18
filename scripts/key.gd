extends Area3D

func _on_body_entered(body):
	if body.name == "Player":
		get_node("/root/Global").has_key = true
		get_parent().visible = false
