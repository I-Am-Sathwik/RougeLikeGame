extends Node
class_name Stats


#Health
export(int) var max_health = 3 setget set_max_health
var health = max_health setget set_health

signal no_health
signal health_changed(value)
signal max_health_changed(value)

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

#Ammo
export(int) var max_ammo = 3 setget set_max_ammo
var ammo = max_ammo setget set_ammo

signal no_ammo
signal ammo_changed(ammo)
signal max_ammo_changed(ammo)

func set_max_ammo(ammo):
	max_ammo = ammo
	self.ammo = min(ammo, max_ammo)
	emit_signal("max_ammo_changed", max_ammo)

func set_ammo(value):
	ammo = value
	emit_signal("ammo_changed", ammo)
	if ammo <= 0:
		emit_signal("no_ammo")

func _ready():
	self.ammo = max_ammo
