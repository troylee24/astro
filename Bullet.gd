extends RigidBody2D

var screensize

func _ready():
	screensize = get_viewport_rect().size

func _physics_process(delta):
	if global_position.x < -10 || global_position.x > screensize.x + 10 || global_position.y < -10 || global_position.y > screensize.y + 10:
		queue_free()
	if Input.is_action_pressed("restart"):
		queue_free()

func _on_Bullet_body_entered(body):
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
