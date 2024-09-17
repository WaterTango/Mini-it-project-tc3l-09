extends StaticBody2D

var in_normal_chest_zone = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$librarychestclosed.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_normal_chest_zone:
		$interact_popup2.show()
		if Input.is_action_just_pressed("interact"):
			$KeySFX.play()
			$interact_popup2.hide()
			$librarychestclosed.hide()
			$librarychestopen.show()
			$emptychest.show()
			in_normal_chest_zone = false
			

func _on_chestopen_area_body_entered(body: Node2D) -> void:
	if body is Player:
		in_normal_chest_zone = true


func _on_chestopen_area_body_exited(body: Node2D) -> void:
	if body is Player:
		in_normal_chest_zone = false
		$interact_popup2.hide()
		$librarychestopen.hide()
		$librarychestclosed.show()
		$emptychest.hide()
