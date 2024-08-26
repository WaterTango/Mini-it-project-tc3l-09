extends CollisionShape2D


func _on_tp_area_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://Scenes/Game_scene/world_2.tscn")
