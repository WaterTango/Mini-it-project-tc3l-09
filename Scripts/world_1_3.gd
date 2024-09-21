extends Node

# shaz's pausemenu =================================================================================
@onready var pause_menu: pausemenu = $entities/Player/Camera2D/PauseMenu #@daniel bro why u typo alot
# i gotta recheck all the directories just to make my code work bruh
var paused = false

# shaz's AudioPlaybackScript =======================================================================
func _ready() -> void:
	$entities/Player/interact_popup2.hide()
	$Entering.play()
	$CanvasLayer/SceneFade.play("fade in")
	await get_tree().create_timer(3).timeout
	$"World 1 Music".play()
	pass
#===================================================================================================

#this is for debug 
#REMOVE WHEN GAME IS RELEASED
func _input(_event):
	#if Input.is_action_pressed("exit"):
		#get_tree().quit()
		#print("quit")
	if Input.is_action_just_pressed('reset') and OS.is_debug_build():
		get_tree().reload_current_scene()
		print("reset")
	#this is to reload levels
	if Input.is_action_just_pressed("transition1") and OS.is_debug_build():
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_1_1.tscn")
	if Input.is_action_just_pressed("transition2") and OS.is_debug_build():
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_2_1.tscn")
	if Input.is_action_just_pressed("transition3") and OS.is_debug_build():
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_3_1.tscn")
	# shaz's code for pause below =================================================================
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
	if Input.is_action_just_pressed("light_off") and OS.is_debug_build():
		$CanvasModulate.hide()
	if Input.is_action_just_pressed("light_on") and OS.is_debug_build():
		$CanvasModulate.show()
# shaz's pausemenu function below =================================================================
func pauseMenu():
	if paused:
		$ResumeSFX.play()
		$CanvasModulate.show()
		pause_menu.hide()
		#Engine.time_scale = 1
		get_tree().paused = false  
		print("[Pause Menu] Game Resumed")
	else:
		$PausedSFX.play()
		$CanvasModulate.hide()
		pause_menu.show()
		#Engine.time_scale = 0  
		get_tree().paused = true
		print("[Pause Menu] Game Paused")
		
	paused = !paused

#==================================================================================================
func _on_tp_area_body_entered(body) -> void:
	if body is Player:
		# shaz's SceneTransitionFadeout =======================================
		$Leaving.play()
		$CanvasLayer/SceneFade.play("fade out")
		await get_tree().create_timer(3).timeout
		# ======================================================================
		print("travelling to world 2_1")
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_2_1.tscn")


func _on_key_popup_hide() -> void:
	$entities/Player/interact_popup2.hide()
	# Shaz's DS4 UI
	$"entities/Player/Camera2D/DS4-UI".hide()

func _on_key_popup_show() -> void:
	$entities/Player/interact_popup2.show()
	# Shaz's DS4 UI
	$"entities/Player/Camera2D/DS4-UI".show()
	

func _on_key_key_pickedup() -> void:
	$entities/Player/Camera2D/key_Notification.show()
