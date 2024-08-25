# main menu script
class_name mainmenu
extends Control

# the button variables (drag, hold ctrl, drop for ease) + (defining the variable)
@onready var startbutton: Button = $MarginContainer/HBoxContainer/VBoxContainer/startbutton as Button
@onready var settingsbutton: Button = $MarginContainer/HBoxContainer/VBoxContainer/settingsbutton as Button
@onready var exitbutton: Button = $MarginContainer/HBoxContainer/VBoxContainer/exitbutton as Button
@onready var settings_menu: settingsmenu = $settings_menu as settingsmenu
@onready var margin_container: MarginContainer = $MarginContainer as MarginContainer

#game initializer
@onready var start_level = preload("res://Scenes/Game_scene/main.tscn") # INSERT THE GAME PATH HERE!!!!1!!1!!

#----------------------------------main function for startup----------------------------------------
func _ready() -> void:
	# center of screen
	center = Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y/2)
	$backgroundmusic.play()
	$AnimationPlayer.play("menu fade in")
	print("animation is fading in...")
	await get_tree().create_timer(3).timeout
	$loadedSFX.play()
	print("welcome to TOWER CRAWER!")
	# Connect the mouse_entered signals to the buttons
	handle_connecting_signals()
	print("button signals connected")

func on_start_pressed() -> void:
	$MarginContainer/HBoxContainer/VBoxContainer/clickSFX.play()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_packed(start_level)
	print("Start Button pressed") # all the print statements are for DEBUGGING just in case
	#$backgroundmusic.stop() - i dont think we need to stop the music as changing scene will remove the player anyways
	pass

func on_settings_pressed() -> void:
	$MarginContainer/HBoxContainer/VBoxContainer/clickSFX.play()
	#get_tree().change_scene_to_packed(settingsmenu) - save it just in case 
	print("Settings Button pressed")
	margin_container.visible = false
	settings_menu.set_process(true)
	settings_menu.visible = true
	pass

func on_exit_pressed() -> void:
	$MarginContainer/HBoxContainer/VBoxContainer/clickSFX.play() # inaudible SFX cuz game is already closed
	print("goodbye world")
	await get_tree().create_timer(1).timeout
	get_tree().quit()

func on_exit_settings_menu() -> void:
	margin_container.visible = true
	settings_menu.visible = false
	pass

func handle_connecting_signals() -> void:
	startbutton.button_down.connect(on_start_pressed)
	settingsbutton.button_down.connect(on_settings_pressed)
	exitbutton.button_down.connect(on_exit_pressed)
	settings_menu.exit_settings_menu.connect(on_exit_settings_menu)

# --------------------------hoverSFX and tweenservice(TS) UI animation------------------------------

# node variables for calling em to do the cool dynamic butter smooth animation
var center : Vector2
@onready var DynamicBGnode = $DynamicBG
@onready var DynamicTitlenode = $MarginContainer/DynamicTitle
@onready var MainBGnode = $MainBG

# tweenservice variables for UI animation
@export var tween_intensity: float
@export var tween_duration: float

# tweenservicve animation activation and processing
func TS_start(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

func _process(_delta: float) -> void:
	button_hovered(startbutton)
	button_hovered(settingsbutton)
	button_hovered(exitbutton)
	# calcs vector between mouse n center (for DynamicBG)
	var BG_Offset = center - get_global_mouse_position() * 0.025
	TS_start(DynamicBGnode, "position", BG_Offset, 1)
	var Title_Offset = center - get_global_mouse_position() * 0.010
	TS_start(DynamicTitlenode, "position", Title_Offset, 1)
	var MainBG_Offset = center - get_global_mouse_position() * 0.0075
	TS_start(MainBGnode, "position" , MainBG_Offset, 1)

func button_hovered(button: Button):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		$MarginContainer/HBoxContainer/VBoxContainer/hoverSFX.play()
		TS_start(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
		#print("Button is hovered, scaling now") - um this just spammed alootta outputs
	else:
		TS_start(button, "scale", Vector2.ONE, tween_duration)
		#print("Button is not hovered, descaling scaling now") - same as above
