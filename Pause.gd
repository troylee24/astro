extends Control

onready var restart_button = $Options/ButtonsMargin/Buttons/RestartButton
onready var pop_up = restart_button.get_popup()

func _ready():
	pop_up.add_item("Yes")
	pop_up.add_item("No")
	pop_up.connect("id_pressed",self,"on_option_pressed")

func _on_RestartButton_pressed():
	ClickMusic.set_music("res://sounds/button_press.wav",-10)
	Loadout.change_loadout()

func on_option_pressed(id):
	var option = pop_up.get_item_text(id)
	if option == "Yes":
		ClickMusic.set_music("res://sounds/cure.wav",-10)
		Master.goto_scene("res://StartMenu.tscn",true)
		Master.stop_all()
		visible = false
	if option == "No":
		ClickMusic.set_music("res://sounds/button_press.wav",-10)
		pop_up.hide()

func _input(event):
	if event.is_action_pressed("pause") && get_tree().paused == false:
		visible = true
		get_tree().paused = true

func _on_Start_Button_pressed():
	ClickMusic.set_music("res://sounds/button_press.wav",-10)
	visible = false
	get_tree().paused = false

func _on_Controls_pressed():
	ClickMusic.set_music2("button_press")
	get_node("CONTROLS Layer/Control").visible = true

func _on_Tips_pressed():
	ClickMusic.set_music2("button_press")
	get_node("TIPS Layer/Control").visible = true

func _on_Gun_Stats_pressed():
	ClickMusic.set_music2("button_press")
	get_node("GUN STATS Layer/Control").visible = true
	get_node("GUN STATS Layer/Stats/TextureButton").visible = true

func _on_BackButton_pressed():
	ClickMusic.set_music2("button_press")
	for layer in get_children():
		if "Layer" in layer.name:
			layer.get_node("Control").visible = false
			if "GUN" in layer.name:
				layer.get_node("Stats/TextureButton").visible = false
