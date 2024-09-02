extends Node

@onready var SceneTransition = $SceneTransition/AnimationPlayer
@onready var start_level2 = preload("res://Scenes/Game_scene/world_2.tscn")

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
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_1.tscn")
	if Input.is_action_just_pressed("transition2"):
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_2.tscn")
	if Input.is_action_just_pressed("transition3"):
		get_tree().change_scene_to_file("res://Scenes/Game_scene/world_3.tscn")


func _on_tp_area_body_entered(body: Node2D) -> void:
	if body is Player:
		SceneTransition.play("fade_in")
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_packed(start_level2)
