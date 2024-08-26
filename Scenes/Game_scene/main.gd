extends Node

#this is for debug 
#REMOVE WHEN GAME IS RELEASED
func _input(_event):
	if Input.is_action_pressed("exit"):
		get_tree().quit()
		print("quit")
