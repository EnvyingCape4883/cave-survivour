extends CharacterBody2D

#customizeble values to speed up testing
@export var Acceleration:float = 0.05

#references
@onready var Health:C_Health = $Health
@onready var Player:C_Player = get_tree().get_first_node_in_group("Player")

var In_Player:bool = false

func _process(delta: float) -> void:
	#reduces the velocity to slow movement overtime
	velocity *= 0.9
	
	velocity += position.direction_to(Player.position).normalized() * Acceleration
	
	#applies the velocity to the positions
	position += velocity
	
	if In_Player:
		Player.Health._DAMAGE(10)

func _KnockBack(Force:float = 0,pos:Vector2 = Vector2(0,0)):
	velocity += pos.direction_to(position) * Force/pos.distance_to(position)

func _death() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == Player:
		In_Player = true
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == Player:
		In_Player = false
