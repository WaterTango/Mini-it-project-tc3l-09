extends Control

@onready var fps_checkbox: CheckBox = $HBoxContainer/fps_checkbox


func _ready() -> void:
	#_on_fps_checkbox_toggled(false)
	pass
#
#func _on_fps_checkbox_toggled(toggled_on: bool) -> void:
	#var fps_nodes = get_tree().get_nodes_in_group("fps_overlay")
	#
	## toggle on and off
	#for i in fps_nodes:
		#i.visible = toggled_on
