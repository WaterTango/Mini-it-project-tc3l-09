extends Control

@onready var label: Label = $FPSlayer/Label as Label

# called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# called every frame, [delta] is the elapsed time since the previous frame
func _process(delta: float) -> void:
	label.text = str(Engine.get_frames_per_second())
