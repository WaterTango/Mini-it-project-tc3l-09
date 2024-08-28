class_name hotkeyrebindbutton
extends Control

@onready var label: Label = $HBoxContainer/Label as Label
@onready var button: Button = $HBoxContainer/Button as Button

@export var action_name : String = "left"


func _ready():
	#picking up inputs
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()

func set_action_name() -> void:
	label.text = "unassigned"
	
	match action_name:
			"left":
				label.text = "Left"
			"right":
				label.text = "Right"
			"up":
				label.text = "Up"
			"down":
				label.text = "Down"
			"sprint":
				label.text = "Sprint"
			"interact":
				label.text = "Interact"
			

func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	print("[SETTINGS > Keybinding] Inputting new keybind boss")
	# prints the available keys
	print(action_keycode, " is for ", action_name)
	button.text = "%s" % action_keycode


func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$ineterfacePressSFX.play()
		button.text = "Input new key"
		set_process_unhandled_key_input(toggled_on)
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			# iterates everything, then sees whats the current action_name and stops from overlapping bindings
			if i.action_name != self.action_name:
				i.button.toggle_mode = false
				i.set_process_unhandled_key_input(false)
		
	else:
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(false)
				
		set_text_for_key()

func _unhandled_key_input(event):
	rebind_action_key(event)
	button.button_pressed = false


# erases current event once action_name is called, adds new one with an event
func rebind_action_key(event) -> void:
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	
	# this makes it so that once the user wants to change a key when a button is pressed, it will wait until
	# a new keybind to be inputted rather than letting them to be able to start another bind (when it is in 
	# "input new key"
	set_process_unhandled_key_input(false)
	set_text_for_key()
	set_action_name()
	$interfaceReleaseSFX.play()
	
