extends StaticBody2D

signal playmobcutscene

func _ready() -> void:
	$AnimatedSprite2D.play("jail_door_closed")


func _on_jail_door_key_jaildoor_opened() -> void:
	$AnimatedSprite2D.hide()
	$jail_door_collision.disabled = true
	$DoorSFX.play()
	await get_tree().create_timer(1).timeout
	emit_signal("playmobcutscene")

func _on_jail_door_key_popup_hide() -> void:
	$interact_popup2.hide()


func _on_jail_door_key_popup_show() -> void:
	$interact_popup2.show()
