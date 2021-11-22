extends StaticBody2D
class_name Door


var enemies: Array = []
var is_open: bool = false setget set_is_open

onready var door_detec_range = $DoorDetecRange

func _ready():
	pass


func get_enemies(enemies: Array):
	self.enemies = enemies
	if enemies == []:
		self.is_open = true
		$AnimationPlayer.play("DoorOpen")
	else:
		self.is_open = false


func set_is_open(value: bool):
	is_open = value
	if value == true:
		door_detec_range.monitoring = true
		door_detec_range.monitorable = true
	else:
		door_detec_range.monitoring = false
		door_detec_range.monitorable = false
		


func _on_DoorDetecRange_body_entered(body):
	if body.is_in_group("Player"):
		if (is_open):
			get_tree().change_scene("res://Scenes/Game.tscn")
