extends Control

@onready var backbutton: Button = $MarginContainer/VBoxContainer/backbutton as Button

func _ready() -> void:
	handle_connecting_signals()
	
func handle_connecting_signals() -> void:
	backbutton.button_down.connect(on_exit_pressed)

func on_exit_pressed() -> void:
	#$clickSFX.play() # inaudible SFX cuz game is already closed
	print("going back to mainmenu")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://shaz_scenes/mainmenu/mainmenu.tscn")
