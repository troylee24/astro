extends TextureButton

export(String) var next_scene
export(String) var gun_num
export(String) var text

onready var button_x = rect_position.x
onready var button_y = rect_position.y
onready var label_x = $Label.rect_position.x

func _ready():
	$Sprite.texture = load("res://weapons/" + gun_num + ".png")
	$Label.text = text

func _on_Button_mouse_entered():
	ClickMusic.set_music("res://sounds/button_press.wav",-12)
	rect_scale = Vector2(1.5,1.5)
	rect_position.y = button_y - 7
	$Label.rect_position.x = label_x - 25

func _on_Button_mouse_exited():
	rect_scale = Vector2(1,1)
	rect_position.y = button_y
	$Label.rect_position.x = label_x

func _on_Button_pressed():
	if next_scene == "none":
		ClickMusic.set_music("res://sounds/cure.wav",-10)
		var menu_name = "/root/StartMenu/" + str(text) + " Layer"
		get_node(menu_name + "/Control").visible = true
		if text == "GUN STATS":
			get_node(menu_name + "/Stats/TextureButton").visible = true
	else:
		Master.stop_all()
		ClickMusic.set_music("res://sounds/cure.wav",-10)
		Master.goto_scene(next_scene,true)
