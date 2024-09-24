extends CharacterBody2D


class_name Player


signal playerdead

#shaz's deathanim ----------------------------------------------------------------------------------
@onready var deathplayer: AnimationPlayer = $CanvasLayer/deathScene/deathplayer2 as AnimationPlayer

#combat values
var health = 100
var player_alive = true
var enemy_inattack_range = false
var enemy_attack_cooldown = true
var died = false
var speed = 150 
var current_dir = "none"
var player_character
var attack_inprogress = false
var can_move = true
var face_right = null
var player_position = $".".position
var knock = 50
var show_healthbar = true
func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	if show_healthbar:
		$HealthBar.show()
		$HPHud.show()
	if show_healthbar == false:
		$HealthBar.hide()
		$HPHud.hide()
		$HPIcon.hide()
		$CornerKnot14x14.hide()
		$CornerKnot14x15.hide()
		
		
		
func _ready():
	$AnimatedSprite2D.play("front_idle")
	$HealthBar.value = health

	
	
	
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
		face_right = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_inprogress == false:
				anim.play("side_idle")
			
	#when player press a it flips the sprite so that it faces left
	if dir == "left":
		anim.flip_h = true
		face_right = false
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
			

func player():
	pass
func player_idle_anim():
	$AnimatedSprite2D.play("front_idle")

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemyMob"):
		enemy_inattack_range = true
		$HealthBar.show()


func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemyMob"):
		enemy_inattack_range = false
		$healthregen.start()
		
#this shit dont work dawg
#func knockback():
		#if face_right:
			#player_position = knock
		#if face_right == false:
			#player_position = -knock
			#
func enemy_attack():
	if enemy_inattack_range and player_alive and enemy_attack_cooldown == true:
		health = health - 20
		$HealthBar.value = health
		$AudioStreamPlayer.play()
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)
		if health <= 0:
			died = true
		if died:
			health = 0
			player_alive = false #player is dead
			$".".can_move = false
			emit_signal("playerdead")
			print("died")

func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true

func _on_playerdead() -> void:
	$CanvasLayer.visible = true
	$AnimatedSprite2D.play("death")
	$player_death.play()
	deathplayer.play("deathscene")
	await get_tree().create_timer(8).timeout
	get_tree().reload_current_scene()
	



#reset the player health
func _on_healthregen_timeout() -> void:
	health = 100
	$regen.play()
	$HealthBar.value = health
	


	
