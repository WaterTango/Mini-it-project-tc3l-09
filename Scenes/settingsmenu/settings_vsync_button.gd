class_name VSync
extends Control

@onready var vsync_optionbutton: OptionButton = $HBoxContainer/Vsync_optionbutton as OptionButton

const VSYNC_ARRAY : Array[String] = [
	"Disabled",
	"Adaptive",
	"Enabled"
]

func _ready() -> void:
	add_vsync_items()
	vsync_optionbutton.item_selected.connect(on_vsync_option_button_item_selected)


func add_vsync_items() -> void:
	for vsync_mode in VSYNC_ARRAY:
		vsync_optionbutton.add_item(vsync_mode)
		

func on_vsync_option_button_item_selected(index: int) -> void:
	$interfaceReleaseSFX.play()
	if index == 0: 
		# disabled 
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		print("[SETTINGS > Video] VSync Disabled!")
	elif index == 1:
		# adaptive
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
		print("[SETTINGS > Video] VSync Adaptive!")
	elif index == 2: 
		# enabled
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		print("[SETTINGS > Video] VSync Enabled!")
		
