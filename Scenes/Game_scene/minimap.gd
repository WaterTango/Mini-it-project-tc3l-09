extends SubViewport
# minimappin
@onready var camera_2d: Camera2D = $Camera2D

func _physics_process(_delta):
	camera_2d.position = owner.find_child("Player").position
