extends Node

var player

func play(music_path,volume):
	player = AudioStreamPlayer.new()
	player.stream = load(music_path)
	player.volume_db = volume
	player.play()
	player.set_name(music_path)
	call_deferred("add_child",player)
	
func stop():
	player.stop()
	
func stop_all():
	for music in get_children():
		music.queue_free()
