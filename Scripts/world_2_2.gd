extends Node2D

# shaz's pausemenu ================================================================================
@onready var pause_menu: pausemenuW2 = $Player/Camera2D/PauseMenu
@onready var settings_menu: settingsmenuInGameW2 = $Player/Camera2D/settings_menu

var paused = false
# shaz's AudioPlaybackScript =======================================================================
func _ready() -> void:
	$army_camp/tentroof.show()
	Dialogic.signal_event.connect(DialogicSignal)
	$Player/interact_popup2.hide()
	$Entering.play()
	$CanvasLayer/SceneFade.play("fade in")
	await get_tree().create_timer(3).timeout
	$"World 2 Music".play()
	#===============================================================================================
	#SceneTransitionAnimation.play("fade_out")
	pass
	
#this is to reload levels
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
	# for resuming, not that paused is !paused
	if paused:
		$ResumeSFX.play()
		pause_menu.hide()
		#Engine.time_scale = 1
		get_tree().paused = false  
		print("[Pause Menu] Game Resumed")
	# paused
	else:
		$PausedSFX.play()
		pause_menu.show()
		#Engine.time_scale = 0  
		get_tree().paused = true
		print("[Pause Menu] Game Paused")
		
	paused = !paused

#==================================================================================================

func _on_tp_area_2_body_entered(body: Node2D) -> void:
	if body is Player:
		# shaz's SceneTransitionFadeout =======================================
		$Leaving.play()
		print("travelling to world 3_1")
		$CanvasLayer/SceneFade.play("fade out")
		await get_tree().create_timer(3).timeout
		# ======================================================================
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_3_1.tscn")

func DialogicSignal(arg: String):
	if arg == "chatting":
		$Player/Camera2D/PauseMenu.modulate.a = 0
		$Player.player_idle_anim()
		$Player.can_move = false
	if arg == "exit":
		$Player/Camera2D/PauseMenu.modulate.a = 1
		$Player.can_move = true
	if arg == "opengate":
		$Doors/gate/gate_collision.disabled = true
		$Doors/gate/Sprite2D.hide()
		
func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)
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


func _on_gate_area_body_entered(body: Node2D) -> void:
	if body is Player:
		run_dialogue("rebellionsoldier")


func _on_commander_area_body_entered(body: Node2D) -> void:
	if body is Player:
		$army_camp/tentroof.hide()
		$Player/Camera2D.zoom.x = 5
		$Player/Camera2D.zoom.y = 5
		# shaz's pausemenuScaling and SFX
		pauseMenuHouseScaling()


func _on_commander_area_body_exited(body: Node2D) -> void:
	if body is Player:
		$army_camp/tentroof.show()
		$Player/Camera2D.zoom.x = 3
		$Player/Camera2D.zoom.y = 3
		# shaz's pausemenuScaling
		pauseMenuDefaultScaling()
