extends CanvasLayer
class_name UI



var player: Player = null

onready var tween: Tween = $Tween


func set_player(player: Player):
	self.player = player

#Health

var hearts = 3 setget set_hearts
var max_hearts = 3 setget set_max_hearts

onready var heartUIFull = $MarginContainer/Rows/TopRow/Hearts/HeartUIEmpty/HeartUIFull
onready var heartUIEmpty = $MarginContainer/Rows/TopRow/Hearts/HeartUIEmpty

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if heartUIFull != null:
		heartUIFull.rect_size.x = hearts * 16
		tween.interpolate_property(heartUIEmpty, "rect_size.x", hearts * 16, hearts, .2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.start()

func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if heartUIEmpty != null:
		heartUIEmpty.rect_min_size.x = max_hearts * 16


#Ammo


var ammo = 6 setget set_ammo
var max_ammo = 6 setget set_max_ammo

onready var bulletEmpty = $MarginContainer/Rows/BottomRow/AmmoSection/BulletEmpty
onready var bulletFull = $MarginContainer/Rows/BottomRow/AmmoSection/BulletEmpty/BulletFull


func set_max_ammo(new_max_ammo):
	if bulletEmpty != null:
		bulletEmpty.rect_min_size.y = new_max_ammo * 8


func set_ammo(new_ammo):
	if bulletFull != null:
		bulletFull.rect_size.y = new_ammo * 8
		tween.interpolate_property(bulletEmpty, "rect_size.y", ammo * 8, ammo, .2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.start()


func _ready():
	#Health
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	PlayerStats.connect("health_changed", self, "set_hearts")
	PlayerStats.connect("max_health_changed", self, "set_max_hearts")
	
	self.max_ammo = PlayerStats.max_ammo
	self.ammo = PlayerStats.ammo
	PlayerStats.connect("ammo_changed", self, "set_ammo")
	PlayerStats.connect("max_ammo_changed", self, "set_max_ammo")

