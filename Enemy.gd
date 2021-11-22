extends KinematicBody2D


class_name Enemy

onready var stats: Stats = $Stats
onready var UI = $UI

export(float) var speed = 10

var path := []
var threshold := 1
var velocity := Vector2.ZERO
var nav_2d: Navigation2D = null


func _ready():
	stats.connect("no_health", self, "queue_free")
	UI.set_enemy(self)
	yield(owner, "ready")
	nav_2d = owner.nav_2d


func handle_hit(bullet, damage):
	if bullet == null:
		return
	if !bullet.is_in_group("Enemy"):
		stats.health -= damage
		if bullet.has_method("kill_me_now"):
			bullet.kill_me_now()


func _physics_process(delta):
	if path.size() > 0:
		move_to_target()
		
func move_to_target():
	if global_position.distance_to(path[0]) < threshold:
		path.remove(0)
	else:
		var direction = global_position.direction_to(path[0])
		velocity = direction * speed
		velocity = move_and_slide(velocity)
		
func get_target_path(target_pos):
	if nav_2d == null:
		return
	path = nav_2d.get_simple_path(global_position, target_pos, false)

