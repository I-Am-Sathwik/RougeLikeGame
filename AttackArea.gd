extends Area2D


func _ready():
	pass


func _on_AttackArea_body_entered(body: Node):
	if body.has_method("handle_hit"):
		body.handle_hit(self, 1)
