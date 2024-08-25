extends Control


@onready var v_sync: CheckButton = $HBoxContainer/VSync as CheckButton

func _ready():
	v_sync.toggled.connect(on_v_sync_toggled)


# vsync toggler when box is checked
func on_v_sync_toggled(toggled_on: bool) -> void:
	#DisplayServer.window_set_vsync_mode() = DisplayServer.VSYNC_ENABLED
	#DisplayServer.window_set_vsync_mode() = DisplayServer.VSYNC_DISABLED
	pass
