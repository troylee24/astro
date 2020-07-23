extends Node

var gun_slots = []
var gun_groups = [[0,5,7],[2,6,9],[1,4,8],[3,10,11]]

func _ready():
	randomize()
	for i in range(4):
		var rand_num = randi()%3
		var gun = gun_groups[i][rand_num]
		gun_slots.append(gun)

func change_loadout():
	var new_guns = []
	randomize()
	for i in range(4):
		var rand_num = randi()%3
		var gun = gun_groups[i][rand_num]
		while gun_slots[i] == gun:
			rand_num = randi()%3
			gun = gun_groups[i][rand_num]
		new_guns.append(gun)
	gun_slots = new_guns
