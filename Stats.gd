extends VBoxContainer

export(int) var fire_rate
export(int) var bullet_speed
export(int) var damage
export(String) var text

func _ready():
	$ColorRect/Fire_Rate.rect_scale.x = fire_rate/100.0
	$ColorRect/Bullet_Speed.rect_scale.x = bullet_speed/100.0
	$ColorRect/Damage.rect_scale.x = damage/100.0
	$ColorRect/HBoxContainer/Label.text = text
