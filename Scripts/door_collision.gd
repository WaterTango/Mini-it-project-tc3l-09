extends CollisionShape2D


func _on_door_1_door_1_collision() -> void:
	print("door collison off")
	$".".disabled = true
	
