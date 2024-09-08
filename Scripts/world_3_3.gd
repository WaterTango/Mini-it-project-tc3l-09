extends Node2D
#this is to reload levels
func _input(_event):
	if Input.is_action_pressed("exit"):
		get_tree().quit()
		print("quit")
	if Input.is_action_just_pressed('reset'):
		get_tree().reload_current_scene()
		print("reset")
	if Input.is_action_just_pressed("transition1"):
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_1_1.tscn")
	if Input.is_action_just_pressed("transition2"):
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_2_1.tscn")
	if Input.is_action_just_pressed("transition3"):
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_3_1.tscn")
		
