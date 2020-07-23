extends RigidBody2D

const AOE_DAMAGE = 50

onready var AOE = load("res://AOE.tscn")
onready var explosion = load("res://Explosion.tscn")
onready var screensize = get_viewport_rect().size

var gun_num
var power = 0 setget set_power, get_power

func set_power(new_power):
	power = new_power

func get_power():
	return power

func _physics_process(_delta):
	if global_position.x < -10 || global_position.x > screensize.x + 10 || global_position.y < -10 || global_position.y > screensize.y + 10:
		queue_free()
	if Input.is_action_pressed("restart"):
		queue_free()

func _on_Bullet_body_entered(body):
	if "Enemy" in body.name:
		if gun_num == 3 || gun_num == 10 || gun_num == 11:
			AOE_effect()
		var explosion_instance = explosion.instance()
		if !("Bullet" in body.name):
			explosion_instance.scale.x = 0.9
			explosion_instance.scale.y = 0.9
			explosion_instance.play("3")
		else:
			explosion_instance.scale.x = 0.3
			explosion_instance.scale.y = 0.3
			explosion_instance.play("1")
		explosion_instance.position = global_position
		get_tree().get_root().call_deferred("add_child",explosion_instance)
		queue_free()
		
func set_bullet(num):
	gun_num = num
	$Sprite.frame = num
	set_collision(num)

func set_collision(num):
	var collision_name = "Collision" + str(num)
	get_node(collision_name).disabled = false
	for collisions in get_children():
		if "Collision" in collisions.name && collisions.name != collision_name:
			collisions.disabled = true

func AOE_effect():
	var AOE_instance = AOE.instance()
	AOE_instance.position = global_position
	AOE_instance.set_power(AOE_DAMAGE)
	get_tree().get_root().call_deferred(("add_child"),AOE_instance)
	var AOE_explosion = explosion.instance()
	AOE_explosion.position = global_position
	AOE_explosion.offset.x = -2
	AOE_explosion.scale.x = 5
	AOE_explosion.scale.y = 5
	AOE_explosion.play("5")
	Master.play("res://sounds/explosion-2.wav",-5)
	get_tree().get_root().call_deferred("add_child",AOE_explosion)
