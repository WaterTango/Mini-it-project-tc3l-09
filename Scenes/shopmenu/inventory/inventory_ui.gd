extends Control

#le inventoryUI script

@onready var Inv: Inventory = preload("res://Scenes/shopmenu/inventory/player inventory.tres")
@onready var slots: Array = $NinePatchRect.get_children()

var isOpen = false

func _ready():
	#Inv.update.connect(update_slots())
	update_slots()
	close()

func update_slots():
	for i in range(min(Inv.slots.size(), slots.size())):
		slots[i].update(Inv.slots[i])
		
func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if isOpen:
			close()
		else:
			open()

func open():
	$backpackSFX.play()
	visible = true
	isOpen = true
func close():
	visible = false
	isOpen = false
