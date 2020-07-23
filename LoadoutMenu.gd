extends Control

onready var slot1 = $VBoxContainer/Row1/Slot1/LoadoutButton/Sprite
onready var slot2 = $VBoxContainer/Row1/Slot2/LoadoutButton/Sprite
onready var slot3 = $VBoxContainer/Row2/Slot3/LoadoutButton/Sprite
onready var slot4 = $VBoxContainer/Row2/Slot4/LoadoutButton/Sprite
onready var slots = [slot1,slot2,slot3,slot4]
onready var dialogue = $Dialogue_Box

func _ready():
	Master.play("res://music/theme-2.ogg",-17)
	for i in range(0,4):
		slots[i].frame = Loadout.gun_slots[i]
	dialogue.set_dialogue(dialogues)

func change_loadout():
	Loadout.change_loadout()
	for i in range(0,4):
		slots[i].frame = Loadout.gun_slots[i]

func set_label():
	$Label.visible = true

var dialogue1 = "Hopefully you read the controls and tips, but if you didn't" \
	+ " no worries. At any point, you can press the [ESC] button..."
var dialogue2 = "... and it'll bring up all of the resources you need. Otherwise," \
	+ " lets jump right into the story."
var dialogue3 = "Welcome to Astro! In this world, your goal is to survive" \
	+ " 5 thirty-second rounds of an alien invasion."
var dialogue4 = "I will provide you with a random loadout of 4 guns to help" \
	+ " you on your journey."
var dialogue5 = "If you're not satisfied with the provided loadout, I can afford" \
	+ " to change it once. Would you me to change it? (Press OK when ready)"
var dialogue6 = "Well that's that then. It's time to start and time for me to" \
	+ " leave. Good luck hero."
var dialogues = [dialogue1,dialogue2,dialogue3,dialogue4,"x",dialogue5,"xx",dialogue6]
