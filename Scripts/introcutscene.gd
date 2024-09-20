extends Node2D

var intro_finished = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$brighten.play("brighten")
	$"World 3 Music".play()
	$Intro.play("Intro")
	Dialogic.signal_event.connect(DialogicSignal)


func _process(delta: float) -> void:
	if intro_finished:
		$"Player king".show()
		$Argus.show()
		$knight.show()
		$knight2.show()
		$knight3.show()
		intro_finished = false
		$guards.play("guards")
		
		
func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)

func scenechange():
	get_tree().change_scene_to_file("res://Scenes/Game_scene/world_1_1.tscn")

func _on_intro_animation_finished(anim_name: ):
	$"Player king".hide()
	$Argus.hide()
	$knight.hide()
	$knight2.hide()
	$knight3.hide()
	run_dialogue("Intro_cutscene")

func DialogicSignal(arg: String):
	if arg == "guard":
		intro_finished = true
		print("intro_cutscene_finished")


func _on_guards_animation_finished(anim_name: StringName) -> void:
	$darken.play("darken")
	await get_tree().create_timer(0.5).timeout
	scenechange()
