extends CollisionShape2D


func _on_door_2_door_2_collision() -> void:
	print("door2 collison off")
	$".".disabled = true
