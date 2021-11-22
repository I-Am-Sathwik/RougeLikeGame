extends Area2D
class_name Bullet

export(int) var speed := 100

var direction := Vector2.ZERO

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		
		global_position += velocity * delta


func set_direction(direction):
	self.direction = direction
	rotation += direction.angle()


func _on_KillTimer_timeout():
	kill_me_now()


func _on_Bullet_body_entered(body: Node):
	if body.has_method("handle_hit"):
		body.handle_hit(self, 1)

func kill_me_now():
	$AnimationPlayer.play("Death")
