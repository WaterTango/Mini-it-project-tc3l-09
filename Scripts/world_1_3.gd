extends Node

func _ready() -> void:
	pass
#this is for debug 
#REMOVE WHEN GAME IS RELEASED
func _input(_event):
	if Input.is_action_pressed("exit"):
		get_tree().quit()
		print("quit")
	if Input.is_action_just_pressed('reset'):
		get_tree().reload_current_scene()
		print("reset")
	#this is to reload levels
	if Input.is_action_just_pressed("transition1"):
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_1_1.tscn")
	if Input.is_action_just_pressed("transition2"):
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_2.tscn")
	if Input.is_action_just_pressed("transition3"):
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_3.tscn")

func _on_tp_area_body_entered(body) -> void:
	if body is Player:
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_2.tscn")
