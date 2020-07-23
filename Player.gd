extends KinematicBody2D

const MAX_SPEED = 250
const MAX_HEALTH = 100

onready var screensize = get_viewport_rect().size
onready var bullet = load("res://Player_Bullet.tscn")
onready var hud = get_parent().get_node("HUD")

var gun_slots = []
var gun_groups = [[0,5,7],[2,6,9],[1,4,8],[3,10,11]]
var bullet_speed = [600,500,1000,700,800,650,900,800,400,700,2000,900]
var bullet_power = [12,10,35,100,15,10,40,8,7,25,150,75]
var gun_delay = [5,4,20,80,8,3,30,3,3,15,100,65]

var move_vec = Vector2.ZERO
var health_bars = 20
var health_per_bar = MAX_HEALTH/health_bars
var total_damage = 0
var gun_num = 0
var time = 0
var shoot_delay = 0
var current_slot = 1
var current_bar_num = 20

func set_gun_slots(new_slots):
	gun_slots = new_slots
	hud.init()
	current_slot = 1
	set_gun(gun_slots[0])

func _ready():
	$Head.texture = load("res://characters/head/" + str(Master.head_num) + ".png")
	$Body.texture = load("res://characters/body/" + str(Master.body_num) + ".png")
	gun_slots = Loadout.gun_slots
	set_gun(gun_slots[0])

func _input(event):
	if event is InputEventKey && event.is_pressed():
		var key = event.scancode - 48
		if key >=1 && key <= 4:
			current_slot = key
			set_gun(gun_slots[key-1])
	elif event.is_action_pressed("RMB"):
		current_slot += 1
		if current_slot > 4:
			current_slot = 1
		set_gun(gun_slots[current_slot-1])

func _process(_delta):
	position.x = clamp(position.x, 10, screensize.x-10)
	position.y = clamp(position.y, 10, screensize.y-10)

func _physics_process(delta):
	var input_vec = Vector2.ZERO
	input_vec.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vec.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vec = input_vec.normalized()
	
	move_vec = move_and_collide(input_vec * MAX_SPEED * delta)
	
	look_at(get_global_mouse_position() + Vector2(0,6.3))
	
	if time >= shoot_delay:
		if Input.is_action_pressed("LMB"):
			shoot()
			time = 0
	else:
		time += 1
	
	
func shoot():
	var bullet_instance = bullet.instance()
	bullet_instance.set_bullet(gun_num)
	bullet_instance.set_power(bullet_power[gun_num])
	bullet_instance.rotation = rotation
	bullet_instance.position = $FirePoint.get_global_position()
	bullet_instance.apply_impulse(Vector2.ZERO,Vector2(bullet_speed[gun_num],0).rotated(rotation))
	get_parent().call_deferred("add_child",bullet_instance)
	bullet_sound()

func bullet_sound():
	var sound
	var volume
	
	match current_slot:
		1:
			sound = "res://sounds/laser.wav"
			volume = -22
		2:
			sound = "res://sounds/laser2.wav"
			volume = -20
		3:
			match gun_num:
				1:
					sound = "res://sounds/laser3.wav"
				4:
					sound = "res://sounds/sword-2.wav"
				8:
					sound = "res://sounds/flame-thrower.wav"
			volume = -15
		4:
			match gun_num:
				3:
					sound = "res://sounds/shoot-2.wav"
				10:
					sound =	"res://sounds/sniper.wav"
				11:
					sound = "res://sounds/big_laser.wav"
			volume = -10
	
	Master.play(sound,volume)

func set_gun(num):
	gun_num = num
	$Gun.frame = num
	set_gun_delay(num)
	hud.set_slot(current_slot)

func set_gun_delay(num):
	shoot_delay = gun_delay[num]
	time = 0

func _on_Area2D_body_entered(body):
	if "Enemy" in body.name:
		if !("Bullet" in body.name):
			total_damage += 15
		if "Bullet" in body.name:
			Master.play("res://sounds/player_hit.wav",-12)
			total_damage += body.get_power()
		var health_remain = max(0,MAX_HEALTH - total_damage)
		update_healthbar(health_remain)
		if total_damage >= MAX_HEALTH:
# warning-ignore:return_value_discarded
			var score = get_parent().get_game_time()
			Master.set_score(score)
			Master.stop_all()
			Master.goto_scene("res://Game_Over.tscn",true)
			
func update_healthbar(health_remain):
	var health_delete = health_remain/health_per_bar + 1
	current_bar_num = health_delete
	while health_delete <= health_bars:
		var bar_num = "Health" + str(health_delete)
		hud.disable_bar(bar_num)
		health_delete += 1
		
func heal():
	total_damage = max(total_damage-20,0)
	var health_to_heal = min(health_bars,current_bar_num+3)
	while current_bar_num <= health_to_heal:
		var bar_num = "Health" + str(current_bar_num)
		hud.enable_bar(bar_num)
		current_bar_num += 1
