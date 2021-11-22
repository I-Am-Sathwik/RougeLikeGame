extends Resource
class_name GunResource

export(String) var name = "Pistol"
export(Image) var sprite = preload("res://Assets/Player/Weapons/Gun_Pistol.png")
export(PackedScene) var bullet = preload("res://Scenes/Bullet.tscn")
export(int) var max_ammo = 6
export(int) var magazine = 6
export(float) var reload_time = 0.6
export(float) var shoot_speed = 0.3
export(bool) var automatic = false
export(Vector2) var gun_tip_pos = Vector2(5, -2)
