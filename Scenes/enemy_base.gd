extends CharacterBody2D

#customizeble values to speed up testing
@export var Acceleration:float = 0.05

#references
@onready var Health = $Health
@onready var Player:CharacterBody2D = get_tree().get_first_node_in_group("Player")

func _process(delta: float) -> void:
	#reduces the velocity to slow movement overtime
	velocity *= 0.9
	
	velocity += position.direction_to(Player.position).normalized() * Acceleration
	
	#applies the velocity to the positions
	position += velocity
