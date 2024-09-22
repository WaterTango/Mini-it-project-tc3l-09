extends StaticBody2D

var gate_close = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(DialogicSignal)
	$Sprite2D.show()

func DialogicSignal(arg: String):
	pass
		
func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_gate_area_body_entered(body: Node2D) -> void:
	if body is Player:
		if gate_close:
			run_dialogue("exit_gate")



func _on_world_2_2_exit_gate_open() -> void:
	$CollisionShape2D.disabled = true
	$Sprite2D.hide()
	gate_close = false
