extends CharacterBody2D

#set variables
const speed = 30
var current_state = IDLE
var dir = Vector2.RIGHT

var is_roaming = true
var is_chatting = false

var player
var player_in_chat_zone = false

var start_pos
#state machine
enum{
	IDLE,     #0
	NEW_DIR,  #1
	MOVE      #2
}


func _ready():
	randomize()
	start_pos = position
	Dialogic.signal_event.connect(DialogicSignal)
#simple state machine
func _process(delta):
	#0 = IDLE
	if current_state == 0:
		$AnimatedSprite2D.play("priest_idle")
	if current_state == 1:
		$AnimatedSprite2D.play("priest_idle")
	if current_state == 2:
		$AnimatedSprite2D.play("priest_run")
	
	match current_state:
		IDLE:
			pass
		NEW_DIR:
			dir = choose([Vector2.RIGHT,Vector2.LEFT])
		MOVE:
			move(delta)
	if Input.is_action_just_pressed("interact") and player_in_chat_zone:
		$AnimatedSprite2D.play("priest_idle")
		run_dialogue("priestnpc_interact")

func run_dialogue(dialogue_string):
	is_chatting = true
	is_roaming = false
	current_state = IDLE
	$Timer.stop()
	
	Dialogic.start(dialogue_string)
	
func DialogicSignal(arg: String):
	if arg == "exit":
		is_chatting = false
		is_roaming = true
		$Timer.start()
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
	move_and_slide()

func choose(array):
	#create an array for randomizer
	array.shuffle()
	return array.front()


func _on_timer_timeout() -> void:
	#create and array to choose random time
	$Timer.wait_time = choose([0.3,0.5,1])
	current_state = choose([IDLE,NEW_DIR,MOVE])


func _on_chat_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		player_in_chat_zone = true
		$interact_popup3.show()



func _on_chat_detection_area_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_chat_zone = false
		is_chatting = false
		$interact_popup3.hide()
