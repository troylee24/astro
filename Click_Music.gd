extends AudioStreamPlayer

onready var button_press = load("res://sounds/button_press.wav")
onready var cure = load("res://sounds/cure.wav")

func _ready():
	pause_mode = PAUSE_MODE_PROCESS

func set_music(music_path,volume):
	set_stream(load(music_path))
	volume_db = volume
	play()

func set_music2(music_path):
	match music_path:
		"button_press":
			set_stream(button_press)
			volume_db = -12
		"cure":
			set_stream(cure)
			volume_db = -10

	play()
