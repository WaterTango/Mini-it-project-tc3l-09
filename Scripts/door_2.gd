extends StaticBody2D

signal door2_collision


func _ready() -> void:
	$AnimatedSprite2D.play("closed")



func _on_key_door_2_opened() -> void:
	$AnimatedSprite2D.play("opened")
	emit_signal("door2_collision")
	
