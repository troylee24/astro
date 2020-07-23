extends Node2D

onready var bars = $HealthBar/Bars
onready var slots = $Slots

func enable_bar(bar_num):
	bars.get_node(bar_num).visible = true
	
func disable_bar(bar_num):
	bars.get_node(bar_num).visible = false

func _ready():
	init()

func init():
	var idx = 0
	for slot in slots.get_children():
		var sprite = slot.get_node("Sprite")
		sprite.frame = Loadout.gun_slots[idx]
		idx += 1

func set_slot(slot_num):
	var name = "Slot" + str(slot_num)
	for slot in slots.get_children():
		if slot.name == name:
			slot.get_node("AnimationPlayer").play("Use")
		else:
			var sprite = slot.get_node("Sprite")
			sprite.scale.x = 1
			sprite.scale.y = 1
