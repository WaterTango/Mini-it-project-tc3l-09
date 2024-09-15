extends CharacterBody2D

class_name Player

var health = 100
var speed = 150 
var current_dir = "none"
var player_character
var attack_inprogress = false
var can_move = true
func _physics_process(delta):
	player_movement(delta)
	attack()
	
func _ready():
	$AnimatedSprite2D.play("front_idle")
	
	
func player_movement(_delta):
	if can_move:
	#diagonal up right 0
		if Input.is_action_pressed("right") and Input.is_action_pressed("up"):
			current_dir = "right"
			play_anim(1)
			velocity.x = speed
			velocity.y = -speed
			#print("diagonal right up")
		#diagonal down right
		elif Input.is_action_pressed("right") and Input.is_action_pressed("down"):
			current_dir = "right"
			play_anim(1)
			velocity.x = speed
			velocity.y = speed
			#print("diagonal right down")
		#diagonal up left
		elif Input.is_action_pressed("left") and Input.is_action_pressed("up"):
			current_dir = "left"
			play_anim(1)
			velocity.x = -speed
			velocity.y = -speed
			#print("diagonal left up")
		#diagonal down left
		elif Input.is_action_pressed("left") and Input.is_action_pressed("down"):
			current_dir = "left"
			play_anim(1)
			velocity.x = -speed
			velocity.y = speed
			#print("diagonal left down")
		elif Input.is_action_pressed("right"):
			current_dir = "right"
			play_anim(1)
			velocity.x = speed
			velocity.y = 0
		elif Input.is_action_pressed("left"):
			current_dir = "left"
			play_anim(1)
			velocity.x = -speed
			velocity.y = 0
		elif Input.is_action_pressed("up"):
			current_dir = "up"
			play_anim(1)
			velocity.x = 0
			velocity.y = -speed
		elif Input.is_action_pressed("down"):
			current_dir = "down"
			play_anim(1)
			velocity.x = 0
			velocity.y = speed	
			
		else:
			play_anim(0)
			velocity.x = 0
			velocity.y = 0
			
		move_and_slide()
#---------------------------------------------------------------------------------------------------------------
#PLAYER ANIMATION
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	#when player press d the sprite face the side
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_inprogress == false:
				anim.play("side_idle")
			
	#when player press a it flips the sprite so that it faces left
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_inprogress == false:
				anim.play("side_idle")
			
	#when player press W the sprite faces up
	if dir == "up":

		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			if attack_inprogress == false:
				anim.play("front_idle")
			
	#when player press S the sprite faces down
	if dir == "down":
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			if attack_inprogress == false:
				anim.play("back_idle")
			
func attack():
	var anim = $AnimatedSprite2D
	if Input.is_action_just_pressed("attack"):
		attack_inprogress = true
		Global.player_current_attack = true
		$attack_timer.start()
		anim.play("aoe_attack")


func player():
	pass


func _on_attack_timer_timeout():
	$attack_timer.stop()
	Global.player_current_attack = false
	attack_inprogress = false
