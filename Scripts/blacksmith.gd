extends Area2D

var shopentered = 0
var totalshopentered = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		# willie wanted me to make it so that if we enter the shop on the 2nd time it'll just popup so here it is :P
		if totalshopentered < 1:
			$"../CanvasLayer/shopmenu/shopintro".active = true
			$"../CanvasLayer/shopmenu/shopintro".play("shop_intro")
			$"../CanvasLayer/shopmenu".show()
			$"../CanvasLayer/SubViewportContainer".hide()
			$"../CanvasLayer/NinePatchRect".hide()
		else:
			$"../CanvasLayer/shopmenu/shopintro".play("RESET")
			$"../CanvasLayer/shopmenu".show()
			$"../CanvasLayer/SubViewportContainer".hide()
			$"../CanvasLayer/NinePatchRect".hide()

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		totalshopentered = totalshopentered + 1
		#print(totalshopentered, "", "totalshopentered") 
		$"../CanvasLayer/shopmenu/shopintro".play("shop_outro")
		$"../CanvasLayer/SubViewportContainer".show()
		$"../CanvasLayer/NinePatchRect".show()
		await get_tree().create_timer(1).timeout
		$"../CanvasLayer/shopmenu".hide()
		
