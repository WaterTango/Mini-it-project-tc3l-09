extends StaticBody2D

signal jaildoor_opened
signal popup_show
signal popup_hide
signal key_pickedup
signal jailkey_used

var jailkeytaken = false
var jail_door_area = false
var jailkey_area = false
var grateopen = false
func _ready() -> void:
	$key.hide()
	$sewer_open.hide()
	
func _process(_delta):
	if jailkeytaken == false and jailkey_area == true:
		if Input.is_action_just_pressed("interact"):
			$sewer_closed.hide()
			$sewer_open.show()
			$key.show()
			$interact_popup2.hide()
			grateopen = true
			
	if grateopen and Input.is_action_just_pressed("interact"):
		$KeySFX.play() # shazSFX
		jailkeytaken = true
		emit_signal("key_pickedup")
		$key.hide()
		grateopen = false
		print("jail key picked up") 
		
	if jailkeytaken == true:
		if jail_door_area == true:
			emit_signal("popup_show")
			if Input.is_action_just_pressed("interact"):
				#$DoorSFX #shaz SFX
				print("jail door opened")
				emit_signal("jaildoor_opened")
				jailkeytaken = false
				grateopen = false
				emit_signal("popup_hide")
				emit_signal("jailkey_used")
				return


func _on_jail_door_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		jail_door_area = true
		print("jail door zone")
		#$DoorSFX #shaz SFX


func _on_jail_door_zone_body_exited(body: Node2D) -> void:
	if body is Player:
		jail_door_area = false
		emit_signal("popup_hide")
		print("not in jaildoor zone")


func _on_jailkey_body_entered(body: Node2D) -> void:
	if body is Player:
		if jailkeytaken == false:
			$interact_popup2.show()
			jailkey_area = true
		


func _on_jailkey_body_exited(body: Node2D) -> void:
	if body is Player:
		$interact_popup2.hide()
		jailkey_area = false
		
