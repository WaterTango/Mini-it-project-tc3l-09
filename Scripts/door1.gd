extends StaticBody2D

signal door1_collision


func _ready() -> void:
	$AnimatedSprite2D.play("closed")



func _on_key_door_1_opened() -> void:
	$DoorSFX.play() #shaz SFX
	$AnimatedSprite2D.play("opened")
	emit_signal("door1_collision")
	
