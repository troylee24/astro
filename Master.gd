extends CanvasLayer

var player
var next
var score = 0
var best_score = 0
var head_num
var body_num

func fade_in():
	$AnimationPlayer.play("fade_in")

func start():
	get_tree().paused = false
	Master.play("res://music/theme-4.ogg",-17)

func set_score(new_score):
	best_score = max(best_score,new_score)
	score = new_score

#SET CHARACTER
func set_head(num):
	head_num = num

func set_body(num):
	body_num = num

#AUDIO CHANGING
func play(music_path,volume):
	player = AudioStreamPlayer.new()
	player.stream = load(music_path)
	player.volume_db = volume
	player.play()
	player.set_name(music_path)
	add_child(player)
		
func stop():
	player.stop()
	
func stop_all():
	for children in get_children():
		if "ogg" in children.name || "wav" in children.name:
			children.queue_free()

#SCENE CHANGING
func goto_scene(next_scene,fade):
	get_tree().paused = true
	next = next_scene
	if fade:
		$AnimationPlayer.play("fade")
	else:
		change()

func change():
# warning-ignore:return_value_discarded
	get_tree().change_scene(next)

# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().paused = false
