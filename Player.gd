extends KinematicBody2D
class_name Player


enum State {
	IDLE,
	RUN
}

export(int) var speed = 50

onready var animationPlayer: AnimationPlayer = $AnimationPlayer
onready var gun: Gun = $Gun
onready var deathParticles: Particles2D = $DeathParticles

var velocity := Vector2.ZERO
var state: int = State.IDLE
#var stats: PlayerStats = PlayerStats
var stats = PlayerStats
var can_move: bool = true
var can_shoot: bool = true

func _ready():
	stats.connect("no_health", self, "death")


func _physics_process(delta):
	match state:
		State.IDLE:
			velocity = Vector2.ZERO
			animationPlayer.play("Idle")
		State.RUN:
			velocity = move_and_slide(velocity * speed)
			animationPlayer.play("Run")
	
	velocity.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if can_shoot:
		shoot()
	
	velocity = velocity.normalized()
	
	gun.look_at(get_global_mouse_position())
	
	if can_move:
		if velocity != Vector2.ZERO:
			state = State.RUN
	else:
		state = State.IDLE


func shoot():
	if gun.automatic == true:
		if Input.is_action_pressed("gun_shoot"):
			gun.shoot()
			if stats.ammo <= 0:
				gun.reload()
	if gun.automatic == false:
		if Input.is_action_just_pressed("gun_shoot"):
			gun.shoot()
			if stats.ammo <= 0:
				gun.reload()
	
	if Input.is_action_pressed("gun_reload"):
		gun.reload()


func handle_hit(bullet, damage):
	if bullet == null:
		return
	if !bullet.is_in_group("Player"):
		stats.health -= damage
		if bullet.has_method("kill_me_now"):
			bullet.kill_me_now()


func kill_me_now():
	animationPlayer.play("Death")

func death():
	modulate = Color.transparent
	can_move = false
	can_shoot = false
