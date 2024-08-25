extends StaticBody2D


signal door1_opened
signal door2_opened 

var keytaken = false
var in_door1_zone = false
var in_door2_zone = false

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if keytaken == false:
		keytaken = true 
		$Sprite2D.queue_free()
		print("key picked up")
		
func _process(_delta):
	if keytaken == true:
		if in_door1_zone == true:
			if Input.is_action_just_pressed("interact"):
				print("door1 opened")
				emit_signal("door1_opened")
				keytaken = false
				return
		elif in_door2_zone == true:
			if Input.is_action_just_pressed("interact"):
				print("door2 opened")
				emit_signal("door2_opened")
				keytaken = false
				return


func _on_door_2_zone_body_entered(body: Node2D) -> void:
	in_door2_zone = true
	print("in door2 zone")


func _on_door_2_zone_body_exited(body: Node2D) -> void:
	in_door1_zone = false
	print("NOT in door2 zone")


func _on_door_1_zone_body_entered(body: Node2D) -> void:
	in_door1_zone = true
	print("in door1 zone")


func _on_door_1_zone_body_exited(body: Node2D) -> void:
	in_door1_zone = false
	print("NOT in door1 zone")
