extends StaticBody2D

signal door1_coldlision


func _ready() -> void:
	$AnimatedSprite2D.play("library_closed")



func _on_key_door_1_opened() -> void:
	$DoorSFX.play()
	$AnimatedSprite2D.play("library_open")
	emit_signal("door1_collision")
	
