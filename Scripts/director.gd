extends CharacterBody2D

var in_chatting_area = false
var firstchat = true
signal secondchat
func _ready() -> void:
	Dialogic.signal_event.connect(DialogicSignal)

	

		
func DialogicSignal(arg: String):
	if arg == "chatting":
		pass
	if arg == "exit":
		pass
	if arg == "firstchat":
		firstchat = false
func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)


func _on_detection_body_entered(body: Node2D) -> void:
	if body is Player:
		if firstchat:
			in_chatting_area = true
			run_dialogue("final_meet")
		
