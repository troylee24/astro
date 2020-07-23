extends Area2D

var power = 0 setget set_power, get_power

func set_power(new_power):
	power = new_power

func get_power():
	return power

func _process(_delta):
	var overlap = get_overlapping_bodies()
	for i in range(0,overlap.size()):
		if "Enemy" in overlap[i].name && !("Bullet" in overlap[i].name):
			overlap[i].add_damage(power)
		if i == overlap.size()-1:
			queue_free()
