extends Node2D

func _ready() -> void:
	$AnimationPlayer.play("fade in ")
	await get_tree().create_timer(8).timeout
	$AnimationPlayer.play("fade out")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://shaz_scenes/mainmenu/mainmenu.tscn")
