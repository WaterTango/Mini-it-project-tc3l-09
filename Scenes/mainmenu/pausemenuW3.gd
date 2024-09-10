class_name pausemenuW3
#for the pause menu
extends Control

@onready var resumebutton: Button = $MarginContainer/VBoxContainer/Resume as Button
@onready var settingsbutton: Button = $MarginContainer/VBoxContainer/Settings as Button
@onready var quitbutton: Button = $MarginContainer/VBoxContainer/Quit as Button
@onready var pause_menu: pausemenuW3 = $"."
@onready var settings_menu: settingsmenuInGameW3 = $"../settings_menu"

@onready var main: Node2D = $"../../.."


#menu initializer
#@onready var back_to_main_menu = preload("res://Scenes/mainmenu/mainmenu.tscn") # for going back to mainmenu

signal exit_pause_menu

func _ready() -> void:
	handle_connecting_pause_signals()
	resumebutton.grab_focus()

func handle_connecting_pause_signals() -> void:
	resumebutton.button_down.connect(_on_resume_pressed)
	settingsbutton.button_down.connect(_on_settings_pressed)
	quitbutton.button_down.connect(_on_quit_pressed)
	pass

func _on_resume_pressed() -> void:
	$ResumeSFX.play()
	main.pauseMenu()
	print("[Pause Menu] Resuming game.")
	pass

func _on_settings_pressed() -> void:
	$MarginContainer/VBoxContainer/clickSFX.play()
	#get_tree().change_scene_to_packed(settingsmenu) - save it just in case 
	print("[Main Menu] Settings Button pressed")
	pause_menu.visible = false
	pause_menu.set_process(false)
	settings_menu.set_process(true)
	settings_menu.visible = true
	print("[Pause Menu] Opening settings.")
	pass 

func _on_quit_pressed() -> void:
	#$MarginContainer/VBoxContainer/clickSFX.play()
	#await get_tree().create_timer(1).timeout
	#get_tree().change_scene_to_file("res://Scenes/mainmenu/mainmenu.tscn") #bugged lul, doesnt even load the mainmenu
	get_tree().quit()
	print("[Pause Menu] Qutting game to main menu.")
	pass
