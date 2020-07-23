extends TextureButton

export(String) var text

onready var label_x = $Label.rect_position.x

func _ready():
	$Label.text = text

func set_gun(gun_num):
	$Sprite.frame = gun_num

func _on_LoadoutButton_mouse_entered():
	ClickMusic.set_music2("button_press")
	set_self_modulate(Color(1,1,1,0.75))
	$Sprite.scale = Vector2(2.8,2.8)
	var text_scale = 1.5
	$Label.rect_scale = Vector2(text_scale,text_scale)
	$Label.rect_position.x -= $Label.rect_size.x/4

func _on_LoadoutButton_mouse_exited():
	set_self_modulate(Color(1,1,1,1))
	$Sprite.scale = Vector2(2,2)
	$Label.rect_scale = Vector2(1,1)
	$Label.rect_position.x = label_x

func _on_LoadoutButton_pressed():
	Master.stop_all()
	ClickMusic.set_music2("cure")
	Master.goto_scene("res://World.tscn",true)
