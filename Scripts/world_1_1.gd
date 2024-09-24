extends Node

# shaz's pausemenu ================================================================================
@onready var pause_menu: pausemenu = $entitites/Player/Camera2D/PauseMenu
@onready var inventory: Control = $CanvasLayer/inventory
@onready var player: Player = $entitites/Player


var paused = false
var NeverChest_tutorial = true
var current_state
# shaz's AudioPlaybackScript =======================================================================
func _ready() -> void:
	key_quest_hide()
	Dialogic.signal_event.connect(DialogicSignal)
	run_dialogue("jailwakeup")
	$CanvasLayer/SceneFade.play("fade in")
	$entitites/Player/interact_popup2.hide()
	$Entering.play()
	await get_tree().create_timer(3).timeout
	$"World 1 Music".play()
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
			$Keys/key.position.x = -440
			$Keys/key.position.y = -128
		POS_2:
			$Keys/key.position.x = 168
			$Keys/key.position.y = -295
		POS_3:
			$Keys/key.position.x = 424
			$Keys/key.position.y = -224
			
			
#====================================================================================================
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
		#Engine.time_scale = 1  #thx raven
		get_tree().paused = false
		print("[Pause Menu] Game Resumed")
	else:
		$PausedSFX.play()
		$CanvasModulate.hide()
		inventory.hide()
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
		print("travelling to world 1_2")
		$CanvasLayer/SceneFade.play("fade out")
		await get_tree().create_timer(3).timeout
		# ======================================================================
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_1_2.tscn")


func _on_key_popup_show() -> void:
	$entitites/Player/interact_popup2.show()
	# Shaz's DS4 UI
	$"entitites/Player/Camera2D/DS4-UI".show()

func _on_key_popup_hide() -> void:
	$entitites/Player/interact_popup2.hide()
	# Shaz's DS4 UI
	$"entitites/Player/Camera2D/DS4-UI".hide()


func _on_key_key_pickedup() -> void:
	$entitites/Player/Camera2D/key_Notification.show()
	$entitites/Player/Camera2D/quest_1/questdetails/key_collect/NkeyObtained.show()


func _on_jail_door_key_key_pickedup() -> void:
	$entitites/Player/Camera2D/jailkey_Notification.show()


func _on_jail_door_key_jailkey_used() -> void:
	$entitites/Player/Camera2D/jailkey_Notification.hide()
	key_quest_show()
	
#=======================================
#dialogic codes 
#========================
func DialogicSignal(arg: String):
	if arg == "chatting":
		$entitites/Player/Camera2D/PauseMenu.modulate.a = 0
		$entitites/Player.player_idle_anim()
		$entitites/Player.can_move = false
	if arg == "exit":
		$entitites/Player/Camera2D/PauseMenu.modulate.a = 1
		$entitites/Player.can_move = true
	if arg == "chesttutorial":
		NeverChest_tutorial = false
func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)


func _on_jaildoor_playmobcutscene() -> void:
	run_dialogue("mobcutscene")


func _on_tutorial_chest_body_entered(body: Node2D) -> void:
	if body is Player:
		if NeverChest_tutorial:
			run_dialogue("chesttutorial")
			$Mark.hide()

func key_quest_show():
	$entitites/Player/Camera2D/quest_1.show()
	$entitites/Player/Camera2D/quest_1/questbanner/Label.hide()
	$entitites/Player/Camera2D/quest_1/questdetails.show()
	$entitites/Player/Camera2D/quest_1/questdetails/key_collect.show()
	$"entitites/Player/Camera2D/quest_1/questdetails/key_collect/key Requirement".show()
	$entitites/Player/Camera2D/quest_1/questdetails/key_collect/NkeyObtained.hide()

func key_quest_hide():
	$entitites/Player/Camera2D/quest_1.hide()
	$entitites/Player/Camera2D/quest_1/questdetails.hide()
