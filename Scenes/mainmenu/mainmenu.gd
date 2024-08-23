# main menu script
class_name mainmenu
extends Control

# the button variables (drag, hold ctrl, drop for ease) + (defining the variable)
@onready var startbutton: Button = $MarginContainer/HBoxContainer/VBoxContainer/startbutton as Button
@onready var settingsbutton: Button = $MarginContainer/HBoxContainer/VBoxContainer/settingsbutton as Button
@onready var controlsbutton: Button = $MarginContainer/HBoxContainer/VBoxContainer/controlsbutton as Button
@onready var exitbutton: Button = $MarginContainer/HBoxContainer/VBoxContainer/exitbutton as Button

# tweenservice variables for UI animation
@export var tween_intensity: float
@export var tween_duration: float

#game initializer
@onready var start_level = preload("mainmenu.tscn") # INSERT THE GAME PATH HERE!!!!1!!1!!

func _ready() -> void:
	$backgroundmusic.play()
	# Connect the mouse_entered signals to the buttons
	handle_connecting_signals()
	# center of screen
	center = Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y/2)

func on_start_pressed() -> void:
	$MarginContainer/HBoxContainer/VBoxContainer/clickSFX.play()
	get_tree().change_scene_to_file("res://Scenes/Game_scene/main.tscn")
	print("Start Button pressed") # all the print statements are for debugging just in case
	$backgroundmusic.stop()
	pass

func on_settings_pressed() -> void:
	$MarginContainer/HBoxContainer/VBoxContainer/clickSFX.play()
	#get_tree().change_scene_to_packed(settingsmenu)
	print("Settings Button pressed")
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://shaz_scenes/settingsmenu.tscn")
	pass

func on_controls_pressed() -> void:
	$MarginContainer/HBoxContainer/VBoxContainer/clickSFX.play()
	print("Controls Button pressed")
	pass

func on_exit_pressed() -> void:
	$MarginContainer/HBoxContainer/VBoxContainer/clickSFX.play() # inaudible SFX cuz game is already closed
	print("goodbye world")
	await get_tree().create_timer(1.5).timeout
	get_tree().quit()

func handle_connecting_signals() -> void:
	startbutton.button_down.connect(on_start_pressed)
	settingsbutton.button_down.connect(on_settings_pressed)
	controlsbutton.button_down.connect(on_controls_pressed)
	exitbutton.button_down.connect(on_exit_pressed)

# hoverSFX and tweenservice(TS) UI animation
func TS_start(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

func _process(_delta: float) -> void:
	button_hovered(startbutton)
	button_hovered(settingsbutton)
	button_hovered(controlsbutton)
	button_hovered(exitbutton)
	# calcs vector between mouse n center (for DynamicBG)
	var BG_Offset = center - get_global_mouse_position() * 0.025
	TS_start(DynamicBGnode, "position", BG_Offset, 1)
	var Title_Offset = center - get_global_mouse_position() * 0.010
	TS_start(DynamicTitlenode, "position", Title_Offset, 1)
	
func button_hovered(button: Button):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		$MarginContainer/HBoxContainer/VBoxContainer/hoverSFX.play()
		TS_start(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		TS_start(button, "scale", Vector2.ONE, tween_duration)

# center coords.
var center : Vector2
@onready var DynamicBGnode = $DynamicBG
@onready var DynamicTitlenode = $MarginContainer/DynamicTitle
