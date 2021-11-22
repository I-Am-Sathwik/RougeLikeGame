extends Node2D
class_name Gun

export(Resource) var gun_resource = null

onready var shoot_speed_timer: Timer = $ShootSpeedTimer
onready var reload_gun_timer: Timer = $ReloadGunTimer
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var sprite: Sprite = $Sprite
onready var gun_tip: Position2D = $GunTip
onready var end_of_gun: Position2D = $EndOfGun

var gun_name: String
var sprite_img: Texture
var max_ammo: int
var ammo: int
var magazine: int
var reload_time: float
var shoot_speed: float
var reload_ammount: int
var automatic: bool
var gun_tip_pos: Vector2
var Bullet: PackedScene

var can_shoot := false
var can_reload := false

var reloading := false

func _ready():
	shoot_speed_timer.start()
	reload_gun_timer.start()
	
	shoot_speed_timer.one_shot = true
	reload_gun_timer.one_shot = true
	
	gun_name = gun_resource.name
	sprite_img = gun_resource.sprite
	max_ammo = gun_resource.max_ammo
	ammo = max_ammo
	magazine = gun_resource.magazine
	reload_time = gun_resource.reload_time
	shoot_speed = gun_resource.shoot_speed
	reload_ammount = magazine
	automatic = gun_resource.automatic
	gun_tip_pos = gun_resource.gun_tip_pos
	Bullet = gun_resource.bullet
	
	gun_tip.position = gun_tip_pos
	end_of_gun.position = Vector2(gun_tip.position.x + 4, gun_tip.position.y)
	sprite.texture = sprite_img
	
	shoot_speed_timer.wait_time = shoot_speed
	reload_gun_timer.wait_time = reload_time
	
	PlayerStats.max_ammo = ammo
	PlayerStats.ammo = magazine

func shoot():
	if can_shoot and !reloading and PlayerStats.ammo != 0:
		var bullet: Bullet = Bullet.instance()
		bullet.global_position = gun_tip.global_position
		get_tree().get_root().add_child(bullet)
		
		var target: Vector2 = end_of_gun.global_position
		var direction_to_target: Vector2 = bullet.global_position.direction_to(target).normalized()
		
		bullet.set_direction(direction_to_target)
		
		animation_player.play("Shoot")
		
		shoot_speed_timer.start()
		can_shoot = false
		PlayerStats.ammo -= 1


func reload():
	if can_reload and PlayerStats.max_ammo > 0:
		animation_player.play("Reload")
		
		reload_gun_timer.start()
		can_reload = false
		reloading = true


func reload_ammo():
#		if ammo > reload_ammount:
		PlayerStats.ammo = reload_ammount
#		else:
#			magazine = ammo
#			ammo -= ammo


func _on_ShootSpeedTimer_timeout():
	can_shoot = true


func _on_ReloadGunTimer_timeout():
	can_reload = true
	reloading = false
