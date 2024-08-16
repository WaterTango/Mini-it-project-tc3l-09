extends CharacterBody2D


@export var speed = 200
@onready var animated_sprite = $AnimatedSprite2D
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
	
	
	var direction = Input.get_axis("left", "right")
	
	#flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	if Input.is_action_pressed("roll"):
		animated_sprite.play("roll")
		
	#else:
		#animated_sprite.play("idle")
	#
	#apply movement

