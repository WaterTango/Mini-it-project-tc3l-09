extends CharacterBody2D

#veriable set
@export var speed = randi_range(50,80)
var player = null
var player_chase = false
var within_range = false

func _physics_process(_delta):
	velocity = Vector2.ZERO
	if player_chase == true and within_range == false:
		position  += (player.position - position) / speed

		#this is so the enemy close the distance to the player 
		$AnimatedSprite2D.play("orc_run")
		if (player.position.x - position.x) <0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("orc_idle")
	move_and_slide()

#godot node to detect when player enter the detection area
func _on_detection_area_body_entered(body) -> void:
	#this to set the body entered as the player
	if body.is_in_group("Player"):
		player = body
		player_chase = true
	#this to signal the physics process that player has entered
		print("chasing")

#godot node to detect when player exit the detection area
func _on_detection_area_body_exited(body) -> void:
	player = null
	player_chase = false

func _on_attack_range_body_entered(body):
	if body.is_in_group("Player"):
		within_range = true
	
func _on_attack_range_body_exited(body):
	within_range = false
