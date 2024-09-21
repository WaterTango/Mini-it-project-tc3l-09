extends Node2D
#this is to reload levels

#this is to reload levels
# shaz's pausemenu ================================================================================
@onready var pause_menu: pausemenuW3 = $Player/Camera2D/PauseMenu

var paused = false
# shaz's AudioPlaybackScript =======================================================================
func _ready() -> void:
	Dialogic.signal_event.connect(DialogicSignal)
	$Entering.play()
	$CanvasLayer/SceneFade.play("fade in")
	await get_tree().create_timer(3).timeout
	$"World 3 Music".play()
	pass

#===================================================================================================

func _input(_event):
	#if Input.is_action_pressed("exit"):
		#get_tree().quit()
		#print("quit")
	if Input.is_action_just_pressed('reset') and OS.is_debug_build():
		get_tree().reload_current_scene()
		print("reset")
	if Input.is_action_just_pressed("transition1") and OS.is_debug_build():
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_1_1.tscn")
	if Input.is_action_just_pressed("transition2") and OS.is_debug_build():
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_2_1.tscn")
	if Input.is_action_just_pressed("transition3") and OS.is_debug_build():
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_3_1.tscn")
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
				
	# shaz's pausemenu function below =================================================================
func pauseMenu():
	if paused:
		$ResumeSFX.play()
		pause_menu.hide()
		#Engine.time_scale = 1
		get_tree().paused = false  
		print("[Pause Menu] Game Resumed")
	else:
		$PausedSFX.play()
		pause_menu.show()
		#Engine.time_scale = 0  
		get_tree().paused = true
		print("[Pause Menu] Game Paused")
		
	paused = !paused

#==================================================================================================
#Dialogic
func DialogicSignal(arg: String):
	if arg == "chatting":
		$Player.can_move = false
		$Player/Camera2D/PauseMenu.modulate.a = 0
		$Player.player_idle_anim()
	if arg == "exit":
		$Player.can_move = true
		$Player/Camera2D/PauseMenu.modulate.a = 1
	if arg == "surround":
		$rebel_soldier.play("rebel_enter")
	if arg == "ending":
		$darken.play("darken")
		
func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)

func _on_key_popup_hide() -> void:
	$Player/interact_popup2.hide()


func _on_key_popup_show() -> void:
	$Player/interact_popup2.show()


func _on_key_key_pickedup() -> void:
	$Player/Camera2D/key_Notification.show()


func _on_rebel_soldier_animation_finished(anim_name: StringName) -> void:
	run_dialogue("final_meet2")


func _on_darken_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Scenes/mainmenu/mainmenu.tscn")
