extends Node2D


func _input(_event):
	if Input.is_action_pressed("exit"):
		get_tree().quit()
		print("quit")
	if Input.is_action_just_pressed('reset'):
		get_tree().reload_current_scene()
		print("reset")
