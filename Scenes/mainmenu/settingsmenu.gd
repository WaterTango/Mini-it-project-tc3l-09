class_name  settingsmenu
extends Control

@onready var backbutton: Button = $MarginContainer/VBoxContainer/backbutton as Button

signal exit_settings_menu

func _ready() -> void:
	handle_connecting_settings_signals()
	
func handle_connecting_settings_signals() -> void:
	backbutton.button_down.connect(on_exit_pressed)
	set_process(false)

func on_exit_pressed() -> void:
	exit_settings_menu.emit()
	set_process(false)
	#$clickSFX.play() 
	print("going back to mainmenu")
