extends Control
#uhhh
var coins = 0

var shop

#var save_shop_path = `user://save`
#buttons

#weapons
@onready var wep_1_button: Button = $ContainerExt/WeaponsCategory/Label/WeaponScroll/Node2D/weapon1/wep1button
@onready var wep_2_button: Button = $ContainerExt/WeaponsCategory/Label/WeaponScroll/Node2D/weapon2/wep2button
@onready var wep_3_button: Button = $ContainerExt/WeaponsCategory/Label/WeaponScroll/Node2D/weapon3/wep3button

#potions
@onready var greenpotbutton: Button = $ContainerExt/PotionsCategory/Label/PotionScroll/Node2D/Potion1/greenpotbutton
@onready var bluepotbutton: Button = $ContainerExt/PotionsCategory/Label/PotionScroll/Node2D/Potion2/bluepotbutton
@onready var purplepotbutton: Button = $ContainerExt/PotionsCategory/Label/PotionScroll/Node2D/Potion3/purplepotbutton
@onready var yellowpotbutton: Button = $ContainerExt/PotionsCategory/Label/PotionScroll/Node2D/Potion4/yellowpotbutton
@onready var redpotbutton: Button = $ContainerExt/PotionsCategory/Label/PotionScroll/Node2D/Potion5/redpotbutton

#equipments
#zzz


func _ready() -> void:
	$AnimationPlayer.play("shop_intro")
	handle_connecting_shop_signals()
	pass # Replace with function body.

#func save_shop():
	#var file = File.new()
	#file.open(save_store_path, file.WRITE_READ)
	#file.store_var(store)
	#file.close()

func handle_connecting_shop_signals() -> void:
	#weps
	wep_1_button.button_down.connect(_on_wep1_pressed)
	wep_2_button.button_down.connect(_on_wep2_pressed)
	wep_3_button.button_down.connect(_on_wep3_pressed)
	pass
	
func _on_wep1_pressed():
	pass

func _on_wep2_pressed():
	pass

func _on_wep3_pressed():
	pass
