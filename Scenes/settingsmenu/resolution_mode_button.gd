extends Control

@onready var option_button: OptionButton = $HBoxContainer/OptionButton

# creates a dictionary for the resolution button by displaying and outputting the res in vector2i.
const RESOLUTION_DICTIONARY : Dictionary = {
	"800 x 600" : Vector2i (800, 600),
	"1152 x 648" : Vector2i(1152, 648),
	"1280 x 720" : Vector2i(1280, 720),
	"1366 x 768" : Vector2i(1366, 768),
	"1600 x 900" : Vector2i(1600, 900),
	"1920 x 1080" : Vector2i(1920, 1080),
	"2160 x 1440" : Vector2i(2160, 1440),
	"3840 x 2160" : Vector2i(3840, 2160)
}

#calls the button and outputs the resolutions
func _ready():
	option_button.item_selected.connect(on_resolution_selected)
	add_resolution_items()
	
	#sets the default res of 1920 x 1080 instead of 800 x 600 (try deleting these lines and see for yourself)
	#var default_resolution = Vector2i(1920, 1080)
	#var default_index = RESOLUTION_DICTIONARY.keys().find("1920 x 1080")
	#option_button.select(default_index)
	#DisplayServer.window_set_size(default_resolution)

# inserts all of the resolutions available to the optionsbox
func add_resolution_items() -> void:
	for resolution_size_txt in RESOLUTION_DICTIONARY:
		option_button.add_item(resolution_size_txt)

# this will change the resolution based on the window, but it wont like upscale or anything for fullscreen, 
# maybe cuz i set it to strectched scaling... oh well
func on_resolution_selected(index: int) -> void:
	$interfaceReleaseSFX.play()
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])
	print("[SETTINGS > VIDEO > RESOLUTION] Resolution is now ", InputEventFromWindow)
