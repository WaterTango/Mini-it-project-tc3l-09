extends Node2D

func _ready() -> void:
	$AnimationPlayer.play("fade in ")
	await get_tree().create_timer(5).timeout
	$AnimationPlayer.play("fade out")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Scenes/mainmenu/mainmenu.tscn")
