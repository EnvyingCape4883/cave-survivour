extends Node2D
class_name C_Enemy_Spawner

@export var Amount:int = 100

@onready var Delay:Timer = $Timer
@onready var enemy: = preload("res://Scenes/enemy_base.tscn")
@onready var Player:C_Player = get_tree().get_first_node_in_group("Player")

func _on_timer_timeout() -> void:
	if Amount <= 0:
		return
	var New_Enemy:C_Enemy_Base = enemy.instantiate()
	var deg = randi_range(0,359)
	New_Enemy.position = Vector2(cos(deg)*200,sin(deg)*randi_range(200,400)) + Player.position
	get_parent().add_child(New_Enemy)
	Amount -= 1
