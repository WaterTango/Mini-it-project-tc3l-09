extends Node2D

@onready var start_level = preload("res://Scenes/Game_scene/introcutscene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("lorecutscene")
	$"World 3 Music".play()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("enter"):
		get_tree().change_scene_to_file("res://Scenes/Game_scene/introcutscene.tscn")



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_packed(start_level)
