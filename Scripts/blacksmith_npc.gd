extends CharacterBody2D


func _ready() -> void:
	$AnimatedSprite2D.play("working")
	
	

func _on_greet_body_entered(body: Node2D) -> void:
	if body is Player:
		$AnimatedSprite2D.play("greet")


func _on_talk_body_entered(body: Node2D) -> void:
	if body is Player:	
		$AnimatedSprite2D.play("idle")


func _on_talk_body_exited(body: Node2D) -> void:
	if body is Player:
		$AnimatedSprite2D.play("working")
