extends Node2D

@onready var SceneTransition = $SceneTransition/AnimationPlayer
# shaz's pausemenu =================================================================================
@onready var pause_menu: pausemenuW2 = $Player/Camera2D/PauseMenu
@onready var settings_menu: settingsmenuInGameW2 = $Player/Camera2D/settings_menu

var paused = false
var chatting = false
var quest_start = false
var petal_key = false
var forest_key = false
var tomb_key = false

signal quest1_finished
# shaz's AudioPlaybackScript =======================================================================
func _ready() -> void:
	$Map/TileMap/village/roof.show()
	$Map/TileMap/village/roofchimney.show()
	$Player/interact_popup2.hide()
	$Entering.play()
	$CanvasLayer/SceneFade.play("fade in")
	await get_tree().create_timer(3).timeout
	$"World 2 Music".play()
	Dialogic.signal_event.connect(DialogicSignal)
	$Player/Camera2D/petalgrovekey_frag.hide()
	$Player/Camera2D/forestisland_frag.hide()
	$Player/Camera2D/tombkey_frag.hide()
	$Player/Camera2D/key_Notification.hide()
	$Player/Camera2D/quest_1/questbanner/opengate.hide()
	#===============================================================================================
	#SceneTransitionAnimation.play("fade_out")
	pass
	#============================================================
# dialogue behaviour
func DialogicSignal(arg: String):
	if arg == "chatting":
		print("chatting with gate soldier")
		chatting = true
		
	if arg == "exit":
		print("exit chatting with gate soldier")
		chatting = false
	if arg == "quest_1_start":
		quest_start = true
		
		
		
func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)
#this is to reload levels
func _input(_event):
	#if Input.is_action_pressed("exit"):
		#get_tree().quit()
		#print("quit")
	if Input.is_action_just_pressed('reset') and OS.is_debug_build():
		get_tree().reload_current_scene()
		print("resetted")
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
# Pausemenu Zoom Compatibility Scaling ===========================================

func pauseMenuDefaultScaling():
	pause_menu.scale = Vector2(.375 , .375)
	pause_menu.position = Vector2(-360, -210)
	settings_menu.scale = Vector2(0.35, 0.35)
	settings_menu.position = Vector2(-335, -180)
	
func pauseMenuHouseScaling():
	pause_menu.scale = Vector2(.2, .2)
	pause_menu.position = Vector2(-192.5, -108.5)
	settings_menu.scale = Vector2(0.2, 0.2)
	settings_menu.position = Vector2(-192.5, -108.5)

#=================================================================================

func _on_tp_area_2_body_entered(body: Node2D) -> void:
	if body is Player:
		# shaz's SceneTransitionFadeout =======================================
		$Leaving.play()
		print("travelling to world 2_2")
		$CanvasLayer/SceneFade.play("fade out")
		await get_tree().create_timer(3).timeout
		# ======================================================================
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_2_2.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		$Map/TileMap/village/roof.hide()
		$Map/TileMap/village/roofchimney.hide()
		$Player/Camera2D.zoom.x = 5
		$Player/Camera2D.zoom.y = 5
		# shaz's pausemenuScaling and SFX
		pauseMenuHouseScaling()
		$Player/Camera2D/quest_1.hide()
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		$Map/TileMap/village/roof.show()
		$Map/TileMap/village/roofchimney.show()
		$Player/Camera2D.zoom.x = 3
		$Player/Camera2D.zoom.y = 3
		# shaz's pausemenuScaling
		pauseMenuDefaultScaling()
		if quest_start:
			$Player/Camera2D/quest_1.show()

func _on_door_opening_animation_body_entered(body: Node2D) -> void:
	if body is Player:
		$Map/TileMap/village/door.hide()
		$DoorOpening.play()

func _on_door_opening_animation_body_exited(body: Node2D) -> void:
	if body is Player:
		$Map/TileMap/village/door.show()
		$DoorClosing.play()

func _on_key_popup_hide() -> void:
	$Player/interact_popup2.hide()
	#Shaz's DS4 UI ==================================================
	$"Player/Camera2D/DS4-UI".hide()

func _on_key_popup_show() -> void:
	$Player/interact_popup2.show()
	#Shaz's DS4 UI ==================================================
	$"Player/Camera2D/DS4-UI".show()


func _on_key_key_pickedup() -> void:
	$Player/Camera2D/key_Notification.show()
	
func _process(delta: float) -> void:
	if chatting:
		$Player.can_move = false
	elif chatting == false:
		$Player.can_move = true
		
	if tomb_key and petal_key and forest_key:
		emit_signal("quest1_finished")
	


func _on_petalgrove_key_body_entered(body: Node2D) -> void:
	if body is Player:
		$KeySFX.play()
		petal_key = true
		$"Player/Camera2D/quest_1/questdetails/N Petal Grove/NkeyObtained".show()
		$"Keys/key fragments/petalgrovekey".queue_free()
func _on_forestislandkey_body_entered(body: Node2D) -> void:
	if body is Player:
		$KeySFX.play()
		forest_key = true
		$"Player/Camera2D/quest_1/questdetails/W Forest Island/WkeyObtained".show()
		$"Keys/key fragments/islandkey".queue_free()

func _on_shatteredtombkey_body_entered(body: Node2D) -> void:
	if body is Player:
		$KeySFX.play()
		tomb_key = true
		$"Player/Camera2D/quest_1/questdetails/E Shattered Tomb/EkeyObtained".show()
		$"Keys/key fragments/tombkey".queue_free()
		

func _on_key_hide_fragnoti() -> void:
	$Player/Camera2D/petalgrovekey_frag.hide()
	$Player/Camera2D/forestisland_frag.hide()
	$Player/Camera2D/tombkey_frag.hide()
	$Player/Camera2D/quest_1.hide()
	$Player/Camera2D/quest_1/questdetails.hide()
	$Player/Camera2D/quest_1/questbanner/questtitle.hide()
	$Player/Camera2D/quest_1/questbanner/opengate.show()

func _on_priestnpc_collect_key() -> void:
	pass # Replace with function body.
