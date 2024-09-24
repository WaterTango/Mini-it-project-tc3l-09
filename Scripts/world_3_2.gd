extends Node2D
#this is to reload levels
# shaz's pausemenu ================================================================================
@onready var pause_menu: pausemenuW3 = $Player/Camera2D/PauseMenu
@onready var inventory: Control = $CanvasLayer/inventory

var paused = false
var current_state
# shaz's AudioPlaybackScript =======================================================================
func _ready() -> void:
	key_quest_show()
	$Player/interact_popup2.hide()
	$Entering.play()
	$CanvasLayer/SceneFade.play("fade in")
	await get_tree().create_timer(3).timeout
	$"World 3 Music".play()
	current_state = choose([POS_1,POS_2,POS_3])
	set_key_pos()
#===================================================================================================
#key_chest random postion
enum{
	POS_1,     #0
	POS_2,  #1
	POS_3   #2
}
#choose keychecst state (Pos)
func choose(array):
	#create an array for randomizer
	array.shuffle()
	return array.front()

func set_key_pos():
	match current_state:
		POS_1:
			$Keys/key.position.x = -216
			$Keys/key.position.y = -123
		POS_2:
			$Keys/key.position.x = -600
			$Keys/key.position.y = -580
		POS_3:
			$Keys/key.position.x = 344
			$Keys/key.position.y = -424
			
#====================================================================================================
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
	# shaz's code for pause below =================================================================
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
	# shaz's pausemenu function below =================================================================
func pauseMenu():
	if paused:
		$ResumeSFX.play()
		pause_menu.hide()
		#Engine.time_scale = 1
		#get_tree().paused = false  
		print("[Pause Menu] Game Resumed")
	else:
		$PausedSFX.play()
		inventory.hide()
		pause_menu.show()
		#Engine.time_scale = 0  
		get_tree().paused = true
		print("[Pause Menu] Game Paused")
		
	paused = !paused

#==================================================================================================

func _on_tp_area_body_entered(body: Node2D) -> void:
	if body is Player:
		# shaz's SceneTransitionFadeout =======================================
		$Leaving.play()
		$CanvasLayer/SceneFade.play("fade out")
		await get_tree().create_timer(3).timeout
		# ======================================================================
		print("travelling to world 3_2")
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_3_3.tscn")


func _on_key_popup_hide() -> void:
	$Player/interact_popup2.hide()
	# Shaz's DS4 UI
	$"Player/Camera2D/DS4-UI".hide()

func _on_key_popup_show() -> void:
	$Player/interact_popup2.show()
	# Shaz's DS4 UI
	$"Player/Camera2D/DS4-UI".show()


func _on_key_key_pickedup() -> void:
	$Player/Camera2D/key_Notification.show()
	$Player/Camera2D/quest_1/questbanner/questtitle.hide()
	$Player/Camera2D/quest_1/questbanner/Label.show()
	$Player/Camera2D/quest_1/questdetails/key_collect/NkeyObtained.show()

func key_quest_show():
	$Player/Camera2D/quest_1.show()
	$Player/Camera2D/quest_1/questdetails.show()
	$Player/Camera2D/quest_1/questdetails/key_collect/NkeyObtained.hide()
