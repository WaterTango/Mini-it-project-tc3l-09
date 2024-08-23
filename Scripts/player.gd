extends CharacterBody2D

const speed = 150 
var current_dir = "none"

func _physics_process(delta):
	player_movement(delta)
	
	
func _ready():
	$AnimatedSprite2D.play("front_idle")
	
	
func player_movement(_delta):

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

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
			
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
			
	if dir == "up":

		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
			
	if dir == "down":	
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")
			
