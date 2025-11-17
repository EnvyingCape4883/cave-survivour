extends CharacterBody2D
class_name C_Player
#customizeble values to speed up testing
@export var Speed:float = 0.1

#references
@onready var Health:C_Health = $Health


func _process(delta: float) -> void:
	#reduces the velocity to slow movement overtime
	velocity *= 0.9
	
	#adds to velocity based on player movement
	velocity += Vector2(Input.get_axis("Move_Left","Move_Right"),
	Input.get_axis("Move_Up","Move_Down")).normalized() * Speed
	
	#applies the velocity to the positions
	position += velocity
	
	#input for testing
	if Input.is_action_just_pressed("TEST_ACTION"):
		pass

#adds knockback force to the player velocity
func _KnockBack(Force:float = 0,pos:Vector2 = Vector2(0,0)):
	velocity += pos.direction_to(position) * Force/pos.distance_to(position)

#kills the charcter based of the _DEATH signal from the Health scene
func _death() -> void:
	pass
