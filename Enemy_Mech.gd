extends KinematicBody2D

const MAX_SPEED = 100
const MAX_HEALTH = 100
const SHOOT_SPEED = 500
const SHOOT_DELAY = 40

onready var screensize = get_viewport_rect().size
onready var bullet = load("res://Enemy_Bullet.tscn")
onready var explosion = load("res://Explosion.tscn")

var time = 0
var total_damage = 0
var bullet_type = 5
var power = 5

func _process(_delta):
	position.x = clamp(position.x, 10, screensize.x-10)
	position.y = clamp(position.y, 10, screensize.y-10)

func _physics_process(delta):
	var Player = get_parent().get_node("Player")
	look_at(Player.position)
	var move_vec = Vector2(MAX_SPEED * delta,0).rotated(rotation)
# warning-ignore:return_value_discarded
	move_and_collide(move_vec)
	
	if time == SHOOT_DELAY:
		shoot()
		time = 0
	else:
		time += 1
	
func shoot():
	var FirePoint1 = $FirePoint1
	var FirePoint2 = $FirePoint2
	create_bullet(FirePoint1)
	create_bullet(FirePoint2)

func create_bullet(fire_point):
	var bullet_instance = bullet.instance()
	bullet_instance.set_bullet(bullet_type)
	bullet_instance.set_power(power)
	bullet_instance.rotation = rotation
	bullet_instance.position = fire_point.get_global_position()
	bullet_instance.apply_impulse(Vector2.ZERO,Vector2(SHOOT_SPEED,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",bullet_instance)

func _on_Area2D_body_entered(body):
	if "Player_Bullet" in body.name:
		add_damage(body.get_power())

func add_damage(damage):
	total_damage += damage
	if total_damage >= MAX_HEALTH:
		var explosion_instance = explosion.instance()
		explosion_instance.play("5")
		Master.play("res://sounds/explosion-1.wav",-10)
		explosion_instance.position = global_position
		explosion_instance.offset.x = -2
		explosion_instance.scale.x = 1.5
		explosion_instance.scale.y = 1.5
		get_tree().get_root().call_deferred("add_child",explosion_instance)
		queue_free()
