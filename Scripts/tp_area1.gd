extends CollisionShape2D

@onready var start_level = preload("res://Scenes/Game_scene/world_2.tscn")


#Scene transition when the player enter the zone
#TEMP CODE
func _on_tp_area_body_entered(body: CharacterBody2D):
	
	get_tree().change_scene_to_file("res://Scenes/Game_scene/world_2.tscn")
