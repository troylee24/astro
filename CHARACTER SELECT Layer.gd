extends CanvasLayer

onready var head = $Control/VBoxContainer/VBoxContainer/Control/Player/Head
onready var body = $Control/VBoxContainer/VBoxContainer/Control/Player/Body
onready var buttons = $Control/VBoxContainer/VBoxContainer/Control

var head_num = 8
var body_num = 2
var scale_size = Vector2(1,1.5)
var default_size = Vector2(1,1)

func _process(_delta):
	head.texture = load("res://characters/head/" + str(head_num) + ".png")
	body.texture = load("res://characters/body/" + str(body_num) + ".png")
	Master.set_head(head_num)
	Master.set_body(body_num)

func _on_HeadLeft_pressed():
	ClickMusic.set_music2("button_press")
	if head_num == 1:
		head_num = 14
	else:
		head_num -= 1

func _on_HeadRight_pressed():
	ClickMusic.set_music2("button_press")
	if head_num == 14:
		head_num = 1
	else:
		head_num += 1

func _on_BodyLeft_pressed():
	ClickMusic.set_music2("button_press")
	if body_num == 1:
		body_num = 3
	else:
		body_num -= 1

func _on_BodyRight_pressed():
	ClickMusic.set_music2("button_press")
	if body_num == 3:
		body_num = 1
	else:
		body_num += 1

func _on_HeadLeft_mouse_entered():
	buttons.get_node("HeadLeft").rect_scale = scale_size

func _on_HeadLeft_mouse_exited():
	buttons.get_node("HeadLeft").rect_scale = default_size

func _on_HeadRight_mouse_entered():
	buttons.get_node("HeadRight").rect_scale = scale_size

func _on_HeadRight_mouse_exited():
	buttons.get_node("HeadRight").rect_scale = default_size

func _on_BodyLeft_mouse_entered():
	buttons.get_node("BodyLeft").rect_scale = scale_size

func _on_BodyLeft_mouse_exited():
	buttons.get_node("BodyLeft").rect_scale = default_size

func _on_BodyRight_mouse_entered():
	buttons.get_node("BodyRight").rect_scale = scale_size

func _on_BodyRight_mouse_exited():
	buttons.get_node("BodyRight").rect_scale = default_size

