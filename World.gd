extends Node2D

onready var screensize = get_viewport_rect().size
onready var roundTimer = $RoundTimer
onready var enemyMech = load("res://Enemy_Mech.tscn")
onready var enemyTurret = load("res://Enemy_Turret.tscn")
onready var mechTimer = $SpawnTimers/MechTimer
onready var turretTimer = $SpawnTimers/TurretTimer
onready var roundDisp = $RoundDisplay/Round
onready var roundPlayer = $RoundDisplay/Round/AnimationPlayer

var round_length = 30
var countdown = round_length
var round_num = 1
var mech_spawn_rate = Vector2(3.5,5)
var turret_spawn_rate = Vector2(5,8)

func get_game_time():
	return ((round_length-countdown) + (round_num-1)*round_length)

func spawn_init():
	var spawnUp = Vector2(int(rand_range(10,screensize.x-10)),10)
	var spawnDown = Vector2(int(rand_range(10,screensize.x-10)),screensize.y-10)
	var spawnLeft = Vector2(10,int(rand_range(10,screensize.y-10)))
	var spawnRight = Vector2(screensize.x-10,int(rand_range(10,screensize.y-10)))
	return [spawnUp,spawnDown,spawnLeft,spawnRight]

func _ready():
	roundPlayer.play("fade_transition")
	$TimerLabel.text = str(countdown)

func _on_RoundTimer_timeout():
	countdown -= 1
	if countdown < 0:
		if round_num == 5:
# warning-ignore:return_value_discarded
			Master.stop_all()
			Master.set_score(round_length*round_num)
			get_tree().change_scene("res://Game_Over.tscn")
		else:
			round_num += 1
			mechTimer.stop()
			turretTimer.stop()	
			roundTimer.stop()
			$RoundDisplay/Round/Label.text = "round " + str(round_num)
			Loadout.change_loadout()
			var gun_slots = Loadout.gun_slots
			$Player.set_gun_slots(gun_slots)
			$Player.heal()
			for children in get_children():
				if "Enemy" in children.name || "Bullet" in children.name:
					children.queue_free()
			Master.stop_all()
			mech_spawn_rate -= Vector2(0.5,0.5)
			turret_spawn_rate -= Vector2(0.75,0.75)
			countdown = round_length
			$TimerLabel.text = str(countdown)
			roundPlayer.play("fade_transition")
	else:
		$TimerLabel.text = str(countdown)

func _on_MechTimer_timeout():
	var enemy = enemyMech.instance()
	var spawnPoints = spawn_init()
	enemy.position = spawnPoints[randi()%3]
	add_child(enemy)

func _on_TurretTimer_timeout():
	var enemy = enemyTurret.instance()
	var spawnPoints = spawn_init()
	enemy.position = spawnPoints[randi()%3]
	add_child(enemy)

# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	Master.play("res://music/theme-3.ogg",-16)
	mechTimer.wait_time = rand_range(mech_spawn_rate.x,mech_spawn_rate.y)
	turretTimer.wait_time = rand_range(turret_spawn_rate.x,turret_spawn_rate.y)
	mechTimer.start()
	turretTimer.start()	
	roundTimer.start()
