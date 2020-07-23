extends RigidBody2D

onready var explosion = load("res://Explosion.tscn")
onready var screensize = get_viewport_rect().size

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
		queue_free()
	if "Player" in body.name:
		if !("Bullet" in body.name):
			var explosion_instance = explosion.instance()
			explosion_instance.scale.x = 0.9
			explosion_instance.scale.y = 0.9
			explosion_instance.play("3")
			explosion_instance.position = global_position
			get_tree().get_root().call_deferred("add_child",explosion_instance)
		queue_free()

func set_bullet(num):
	$Sprite.frame = num
	set_collision(num)

func set_collision(num):
	var collision_name = "Collision" + str(num)
	get_node(collision_name).disabled = false
	for collisions in get_children():
		if "Collision" in collisions.name && collisions.name != collision_name:
			collisions.disabled = true
