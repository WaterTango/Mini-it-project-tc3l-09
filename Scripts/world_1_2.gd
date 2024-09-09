extends Node

# shaz's pausemenu ================================================================================
@onready var pause_menu: pausemenu = $entities/Player/Camera2D/PauseMenu

var paused = false
#==================================================================================================

func _ready() -> void:
	$"World 1 Music".play()
	pass
#this is for debug 
#REMOVE WHEN GAME IS RELEASED
func _input(_event):
	if Input.is_action_pressed("exit"):
		get_tree().quit()
		print("quit")
	if Input.is_action_just_pressed('reset'):
		get_tree().reload_current_scene()
		print("reset")
	#this is to reload levels
	if Input.is_action_just_pressed("transition1"):
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_1_1.tscn")
	if Input.is_action_just_pressed("transition2"):
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_2_1.tscn")
	if Input.is_action_just_pressed("transition3"):
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_3_1.tscn")
	# shaz's code for pause below =================================================================
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
# shaz's pausemenu function below =================================================================
func pauseMenu():
	if paused:
		$ResumeSFX.play()
		pause_menu.hide()
		Engine.time_scale = 1
		#get_tree().paused = true  
		print("[Pause Menu] Game Resumed")
	else:
		$PausedSFX.play()
		pause_menu.show()
		Engine.time_scale = 0  
		#get_tree().paused = false
		print("[Pause Menu] Game Paused")
		
	paused = !paused

#==================================================================================================
func _on_tp_area_body_entered(body) -> void:
	if body is Player:
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_1_3.tscn")
