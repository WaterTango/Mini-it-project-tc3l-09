extends StaticBody2D

signal door1_opened
signal popup_show
signal popup_hide

var keytaken = false
var in_door1_zone = false

func _on_area_2d_body_entered(body) -> void:
	if body is Player:
		if keytaken == false:
			$KeySFX.play() # shazSFX
			keytaken = true 
			$Sprite2D.queue_free()
			$Area2D.queue_free()
			print("key picked up")

func _process(_delta):
	if keytaken == true:
		if in_door1_zone == true:
			emit_signal("popup_show")
			if Input.is_action_just_pressed("interact"):
				#$DoorSFX #shaz SFX
				print("door1 opened")
				emit_signal("door1_opened")
				keytaken = false
				emit_signal("popup_hide")
				return
				
func _on_door_1_zone_body_entered(body) -> void:
	if body is Player:
		in_door1_zone = true
		print("in door1 zone")
		#$DoorSFX #shaz SFX



func _on_door_1_zone_body_exited(body) -> void:
	if body is Player:
		in_door1_zone = false
		emit_signal("popup_hide")
		print("NOT in door1 zone")
		
