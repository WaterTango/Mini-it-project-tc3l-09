extends Control
#
@onready var v_sync_checkbox: CheckBox = $HBoxContainer/VSync_checkbox
#
func _ready():
	#on_v_sync_toggled()
	pass
#
## vsync toggler when box is checked
#func _on_v_sync_checkbox_toggled(toggled_on: bool) -> void:
	#if toggled_on: true
	#DisplayServer.window_set_vsync_mode()
	#elif toggled_on: false
	#DisplayServer.VSYNC_DISABLED
