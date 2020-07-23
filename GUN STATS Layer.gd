extends CanvasLayer

onready var control = $Control
onready var stats = $Stats
onready var back_button = $Control/VBoxContainer/MarginContainer2/BackButton
var already_pressed = false

func _on_TextureButton_pressed():
	if already_pressed:
		control.visible = true
		back_button.visible = true
		back_button.visible = true
		stats.get_node("TextureRect").visible = false
		stats.get_node("VBoxContainer").visible = false
		stats.get_node("VBoxContainer2").visible = false
		already_pressed = false
	else:
		control.visible = false
		back_button.visible = false
		back_button.visible = false
		stats.get_node("TextureRect").visible = true
		stats.get_node("VBoxContainer").visible = true
		stats.get_node("VBoxContainer2").visible = true
		already_pressed = true
