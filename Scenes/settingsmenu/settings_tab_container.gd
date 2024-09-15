extends Control

@onready var video: TabBar = $TabContainer/Video as TabBar
@onready var tab_container: TabContainer = $TabContainer as TabContainer

func _ready() -> void:
	tab_container.get_tab_bar().grab_focus()
