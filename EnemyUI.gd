extends Control


class_name EnemyUI

onready var healthBar: ProgressBar = $HealthBar
onready var tween: Tween = $Tween

var health := 3 setget set_health
var max_health := 3 setget set_max_health


var enemy: Enemy = null


func set_enemy(enemy: Enemy):
	self.enemy = enemy

func set_health(value):
	health = clamp(value, 0, max_health)
	healthBar.value = health
	tween.interpolate_property(healthBar, "modulate", Color.white, Color(1, 1, 0), .2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.interpolate_property(healthBar, "value", health+1, health, .2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()

func set_max_health(value):
	max_health = max(value, 1)
	self.health = min(health, max_health)
	healthBar.max_value = max_health

func _process(delta):
	if enemy == null:
		return
	self.max_health = enemy.stats.max_health
	self.health = enemy.stats.health
	enemy.stats.connect("health_changed", self, "set_health")
	enemy.stats.connect("max_health_changed", self, "set_max_health")
	if enemy != null:
		set_process(false)
