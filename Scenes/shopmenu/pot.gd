extends RichTextLabel

func _process(delta: float) -> void:
	$Node2D.position.x = -$HScrollBar.value
