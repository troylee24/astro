extends Control

onready var dialogue = $Control/Dialogue
onready var player = $Control/Dialogue/AnimationPlayer
onready var timer = $Control/Dialogue/Timer
onready var ok_button = $Control/Dialogue/OkButton
onready var keep_button = $Control/Dialogue/KeepButton
onready var change_button = $Control/Dialogue/ChangeButton

var dialogues = []
var idx = 0
var done = false

func _ready():
	dialogue.set_visible_characters(0)

func set_dialogue(dialogue_array):
	dialogues = dialogue_array
	dialogue.text = dialogues[0]

func _on_Timer_timeout():
	if dialogue.get_visible_characters() > dialogues[idx].length():
		done = true
	else:	
		dialogue.set_visible_characters(dialogue.get_visible_characters()+1)

func _on_OkButton_pressed():
	if done:
		idx += 1
		if idx >= dialogues.size():
			timer.stop()
			player.play("fade_out")
		else:
			if dialogues[idx] != "xx":
				dialogue.set_visible_characters(0)
			if dialogues[idx] == "x":
				idx += 1
				player.play("fade_out_to_in")
			elif dialogues[idx] == "xx":
				idx += 1
				ok_button.visible = false
				keep_button.visible = true
				change_button.visible = true
			else:
				timer.start()
				done = false
				dialogue.text = dialogues[idx]
	else:
		timer.stop()
		dialogue.set_visible_characters(-1)
		done = true

func _on_KeepButton_pressed():
	dialogue.set_visible_characters(0)
	ok_button.visible = true
	keep_button.visible = false
	change_button.visible = false
	timer.start()
	done = false
	dialogue.text = dialogues[idx]

func _on_ChangeButton_pressed():
	dialogue.set_visible_characters(0)
	player.play("fade_out_to_in2")

func change_loadout():
	get_parent().change_loadout()

func set_label():
	get_parent().set_label()

func _on_AnimationPlayer_animation_finished(anim_name):
	if "fade_out_to_in" in anim_name:
		if "2" in anim_name:
			ok_button.visible = true
			keep_button.visible = false
			change_button.visible = false
		timer.start()
		done = false
		dialogue.text = dialogues[idx]
		
