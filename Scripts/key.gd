extends StaticBody2D

signal door1_opened
signal popup_show
signal popup_hide
signal key_pickedup
signal doorblocked_notification
signal hide_fragnoti

var door_opened = false
var keytaken = false
var in_door1_zone = false
var chestopen = false
var in_chest_zone = false
var door_noti = false
var key_enabled = false
func _ready() -> void:
	$key.hide()
	$librarychestopen.hide()
	Dialogic.signal_event.connect(DialogicSignal)

func DialogicSignal(arg: String):
	if arg == "chatting":
		pass
	if arg == "exit":
		pass

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)
	
func _process(_delta):
	if keytaken == false and in_chest_zone:
		if Input.is_action_just_pressed("interact"):
			$librarychestclosed.hide()
			$librarychestopen.show()
			$key.show()
			$interact_popup2.hide()
			chestopen = true
			
	if chestopen and Input.is_action_just_pressed("interact"):
		$KeySFX.play() # shazSFX
		keytaken = true
		emit_signal("key_pickedup")
		$key.hide()
		chestopen = false
		emit_signal("hide_fragnoti")
		print("key picked up") 
		
	if keytaken == true:
		if in_door1_zone == true:
			emit_signal("popup_show")
			if Input.is_action_just_pressed("interact"):
				#$DoorSFX #shaz SFX
				print("door1 opened")
				emit_signal("door1_opened")
				keytaken = false
				door_opened = true
				emit_signal("popup_hide")
				return
	if keytaken == false and in_door1_zone == true and door_opened == false and door_noti == false: 
		if Input.is_action_just_pressed("interact"):
			run_dialogue("door_blocked")
			emit_signal("doorblocked_notification")
			
			
func _on_door_1_zone_body_entered(body) -> void:
	if body is Player:
		in_door1_zone = true
		print("in door1 zone")
		#$DoorSFX #shaz SFX



func _on_door_1_zone_body_exited(body) -> void:
	if body is Player:
		in_door1_zone = false
		emit_signal("popup_hide")
		print("NOT in door1 zone")
		


func _on_chestopen_area_body_entered(body) -> void:
	if body is Player:
		$interact_popup2.show()
		print("in key_chest area")
		in_chest_zone = true
		
func _on_chestopen_area_body_exited(body: Node2D) -> void:
	if body is Player:
		$interact_popup2.hide()
		in_chest_zone = false


func _on_doorblocked_notification() -> void:
	door_noti = true


func _on_priestnpc_collect_key() -> void:
	$KeySFX.play() # shazSFX
	keytaken = true
	emit_signal("key_pickedup")
	emit_signal("hide_fragnoti")
	print("key picked up") 
