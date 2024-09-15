extends CharacterBody2D

const speed = 50
var current_state = IDLE


var dir = Vector2.RIGHT
var start_pos

var is_roaming = true
var is_chatting = false

var player
var player_in_chat_zone = false

#simple state machine 
enum {
	IDLE,
	NEW_DIR,
	MOVE
}
func _ready():
	randomize()
	#to set the stating postion in the map 
	start_pos = position
	#this is to recieve dialogic signal (var can be changed)
	Dialogic.signal_event.connect(DialogicSignal)
	
	
func _process(delta: float) -> void:
		#0 = IDLE 1 = NEW_DIR 2 = MOVE	
	if current_state == 0 or current_state == 1:
		$AnimatedSprite2D.play("chatting_soldier_idle")
	if current_state == 2:
		$AnimatedSprite2D.play("chatting_soldier_run")	
	elif current_state == 2 and !is_chatting:
		if dir.x == 1:
			$AnimatedSprite2D.flip_h = false
		if dir.x == -1:
			$AnimatedSprite2D.flip_h = true
		
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT,Vector2.LEFT])
			MOVE:
				move(delta)
	if Input.is_action_just_pressed("interact") and player_in_chat_zone:
		$AnimatedSprite2D.play("chatting_soldier_idle")
		run_dialogue("soldiernpc_interact")
		
func choose(array):
	array.shuffle()
	return array.front()
	
	
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
	if !is_chatting:
		position += dir * speed * delta
			#flip the sprite
	if dir.x == 1:
		$AnimatedSprite2D.flip_h = false
	elif dir.x == -1:
		$AnimatedSprite2D.flip_h = true
	if position.x >= start_pos.x + 20:
		position.x = start_pos.x + 19
	if position.x <= start_pos.x - 20:
		position.x = start_pos.x - 19
	move_and_slide()

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5,0.7,1])
	current_state = choose([IDLE,NEW_DIR,MOVE])

func _on_chat_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		player_in_chat_zone = true
		$interact_popup2.show()
		$"../../../Player/Camera2D".zoom.x = 5
		$"../../../Player/Camera2D".zoom.y = 5

func _on_chat_detection_area_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_chat_zone = false
		is_chatting = false
		$interact_popup2.hide()
		$"../../../Player/Camera2D".zoom.x = 3
		$"../../../Player/Camera2D".zoom.y = 3
