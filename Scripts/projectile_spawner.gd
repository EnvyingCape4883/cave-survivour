extends Node2D
class_name C_Projectile_Spawner

@export var Projectile_Type:C_Projectile_Type_RE = C_Projectile_Type_RE.new()
@export_enum("Player","Enemy") var Target:String

@onready var Projectile = preload("res://Scenes/projectile.tscn")
@onready var Spawn_Rate_Timer:Timer = $Spawn_Rate
func _ready() -> void:
	Spawn_Rate_Timer.wait_time = Projectile_Type.Fire_Rate

func _on_spawn_rate_timeout() -> void:
	var New_Projectile:C_Projectile = Projectile.instantiate()
	New_Projectile.Projectile_Type = Projectile_Type
	New_Projectile.Target = Target
	New_Projectile.position = get_parent().position
	get_parent().get_parent().add_child(New_Projectile)
