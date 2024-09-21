extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	Zoom()
	
	


#this is for debug remember to remove later
func Zoom():
	if Input.is_action_just_pressed("zoom-in") and OS.is_debug_build():
		zoom = zoom * 1.1
	if Input.is_action_just_pressed("zoom-out") and OS.is_debug_build():
		zoom = zoom * 0.9
