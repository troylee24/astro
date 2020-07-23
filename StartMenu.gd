extends Control

onready var control

func _ready():
	Input.set_custom_mouse_cursor(load("res://hud/cursor.png"),Input.CURSOR_ARROW,Vector2.ZERO)
	Master.fade_in()
	$Particles2D.emitting = true

func _on_BackButton_pressed():
	ClickMusic.set_music2("button_press")
	for layer in get_children():
		if "Layer" in layer.name:
			layer.get_node("Control").visible = false
			if "GUN" in layer.name:
				layer.get_node("Stats/TextureButton").visible = false
