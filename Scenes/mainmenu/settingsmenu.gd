class_name  settingsmenu
extends Control

@onready var backbutton: Button = $MarginContainer/VBoxContainer/backbutton as Button
@onready var pause_menu: pausemenu = $entitites/Player/Camera2D/PauseMenu

signal exit_settings_menu

func _ready() -> void:
	handle_connecting_settings_signals()
	
func handle_connecting_settings_signals() -> void:
	backbutton.button_down.connect(on_exit_pressed)
	set_process(false)

func on_exit_pressed() -> void:
	$clickSFX.play()
	exit_settings_menu.emit()
	set_process(false)
	print("[Main Menu > Settings] Going back to Main Menu...")
