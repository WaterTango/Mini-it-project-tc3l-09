extends CharacterBody2D

#veriable set
var speed = 45
var player_chase
var player = null

func _physics_process(_delta):
	if player_chase:
		#this is so the enemy close the distance to the player 
		position += (player.position - position)/speed
		$AnimatedSprite2D.play("walk")
		
		
		if (player.position.x - position.x) <0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")

#godot node to detect when player enter the detection area
func _on_detection_area_body_entered(body: Node2D) -> void:
	#this to set the body entered as the player
	player = body
	#this to signal the physics process that player has entered
	player_chase = true
	print("chasing")
	


#godot node to detect when player exit the detection area
func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false
