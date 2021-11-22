extends YSort

var enemies: Array = []
var nav_2d: Navigation2D
var player: Player
var target: Vector2

signal enemies_dead


func set_nav_2d(nav_2d: Navigation2D):
	self.nav_2d = nav_2d


func set_player(player: Player):
	self.player = player


func _process(delta):
	enemies = get_children()
	enemies.pop_back()
	if enemies == []:
		emit_signal("enemies_dead")
		set_process(false)

func _on_SlimeTimer_timeout():
	if player == null:
		return
	target = player.global_position
	get_tree().call_group("Enemy", 'get_target_path', target)
