extends Node2D
class_name C_Enemy_Spawner

@export var Enemy_Amount:int = 100
var Enemy_Type:C_Enemy_Type_RE = C_Enemy_Type_RE.new()
var Completed:bool = false

signal Spawning_Complete

@onready var Delay:Timer = $Timer
@onready var enemy: = preload("res://Scenes/enemy_base.tscn")
@onready var Player:C_Player = get_tree().get_first_node_in_group("Player")

func _on_timer_timeout() -> void:
	if Enemy_Amount <= 0:
		Completed = true
		Spawning_Complete.emit()
		return
	Completed = false
	var New_Enemy:C_Enemy_Base = enemy.instantiate()
	var deg = randi_range(0,359)
	New_Enemy.position = Vector2(cos(deg)*200,sin(deg)*randi_range(200,400)) + Player.position
	New_Enemy.Enemy_Type = Enemy_Type
	get_parent().add_child(New_Enemy)
	Enemy_Amount -= 1

func _Add_Enimies(Amount:int = 100, Type:C_Enemy_Type_RE = C_Enemy_Type_RE.new()):
	if Completed == true:
		Enemy_Type = Type
		Enemy_Amount = Amount
