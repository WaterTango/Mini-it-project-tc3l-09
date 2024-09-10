extends Control

@onready var video: TabBar = $TabContainer/Video as TabBar

func _ready() -> void:
	video.grab_focus()
