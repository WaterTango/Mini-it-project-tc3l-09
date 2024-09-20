extends CharacterBody2D

#veriable set
var speed = 20
var move_speed = 70
var player = null
var within_range = false
var within_player_range = false
var health = 60
var current_state = IDLE
var dir = Vector2.RIGHT

var start_pos

#state machine
enum{
	IDLE,     #0
	NEW_DIR,  #1
	MOVE,     #2
	CHASE     #3
}

func _ready():
	randomize()
	start_pos = position
	
#simple state machine
func _process(delta):
	#0 = IDLE
	if current_state == 0:
		$AnimatedSprite2D.play("zombie_idle")
	if current_state == 1:
		$AnimatedSprite2D.play("zombie_idle")
	if current_state == 2:
		$AnimatedSprite2D.play("zombie_run")
	
	match current_state:
		IDLE:
			$AnimatedSprite2D.play("zombie_idle")
		NEW_DIR:
			dir = choose([Vector2.RIGHT,Vector2.LEFT])
		MOVE:
			move(delta)
		CHASE:
			chase(delta)
			
func move(delta):
	#move the character
	position += dir * speed * delta
	#flip the sprite
	if dir.x == 1:
		$AnimatedSprite2D.flip_h = false
	elif dir.x == -1:
		$AnimatedSprite2D.flip_h = true
	#set the boundary of movement
	if position.x >= start_pos.x + 10:
		position.x = start_pos.x + 9.9
	if position.x <= start_pos.x - 10:
		position.x = start_pos.x - 9.9

func chase(delta):
	$AnimatedSprite2D.play("zombie_run")
		#flip the sprite
	if (player.position.x - position.x) <0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
		
	position  += (player.position - position) / move_speed
	$Timer.stop()
	$AnimatedSprite2D.play("zombie_run")
	move_and_slide()		
	
func choose(array):
	#create an array for randomizer
	array.shuffle()
	return array.front()


func _on_timer_timeout() -> void:
	#create and array to choose random time
	$Timer.wait_time = choose([0.5,1,1.5])
	current_state = choose([IDLE,NEW_DIR,MOVE])
#godot node to detect when player enter the detection area

func deal_with_damage():
	if within_player_range and Global.player_current_attack == true:
		health -= 20
		print("enemy health = ", health)
		if health <= 0:
			#$AnimatedSprite2D.play("skeleton_death")
			self.queue_free()

func _on_player_attack_range_body_entered(body):
	if body is Player:
		within_player_range = true

func _on_player_attack_range_body_exited(body):
	if body is Player:
		within_player_range = false
		$Timer.start()

func _on_attack_range_body_entered(body):
	if body.is_in_group("Player"):
		within_range = true

func _on_attack_range_body_exited(body):
	if body.is_in_group("Player"):
		within_range = false


func _on_detection_body_entered(body: Node2D) -> void:
	#this to set the body entered as the player
	if body is Player:
		player = body
		current_state = CHASE
	#this to signal the physics process that player has entered
		print("chasing")


func _on_detection_body_exited(body: Node2D) -> void:
	if body is Player:
		current_state = IDLE
		$Timer.start()

func enemyMob():
	pass
