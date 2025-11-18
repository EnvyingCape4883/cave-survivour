extends CharacterBody2D
class_name C_Enemy_Base

#enemy type resource
var Enemy_Type:C_Enemy_Type_RE = C_Enemy_Type_RE.new()

#attackig var stops movement if true is anabled once the attack starts
var Attacking:bool = false

#reference to the player
@onready var Player:C_Player = get_tree().get_first_node_in_group("Player")

#referance to the health scene
@onready var Health:C_Health = $Health
#referance to the collision shape 2D node attatched to the enemy base node
@onready var Collision_Shape:CollisionShape2D = $CollisionShape2D
#referance to the melee xone node
@onready var Melee_Zone:Area2D = $MeleeZone
#referance to the contact xone node
@onready var Contact_Zone:Area2D = $ContactZone
#referance to the melee timer node
@onready var Melee_Timer:Timer = $Melee
#referance to the animadted sprite 2D node
@onready var Anim_Sprite:AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	#sets values for the health scene to the values from the Enemy Type resource
	Health.MAX_HEALTH = Enemy_Type.Max_Health
	Health.DEFENCE = Enemy_Type.Defence
	
	#sets the Shape and position For the Melee Zone to the values from the Enemy Type resource
	Melee_Zone.get_child(0).shape = Enemy_Type.Melee_Shape
	Melee_Zone.get_child(0).position = Enemy_Type.Melee_Shape_Pos
	#sets the speed of the melee attacks to the values from the Enemy Type resource
	Melee_Timer.wait_time = Enemy_Type.Melee_Rate
	
	#Sets the collision and contact radius to the values from the Enemy Type resource
	Collision_Shape.shape.radius = Enemy_Type.Collision_Radius
	Contact_Zone.get_child(0).shape.radius = Enemy_Type.Collision_Radius

func _process(delta: float) -> void:
	#reduces the velocity to slow movement overtime
	velocity *= 0.9
	
	#adds velocity in the direction to the player unless the enemy is attacking with a melee attack
	if !Attacking:
		velocity += position.direction_to(Player.position).normalized() * Enemy_Type.Speed
		rotation = position.direction_to(Player.position).normalized().angle()
	
	#applies damage to the player if the player is touching the enemy and only inf contact damage is enabled
	if Enemy_Type.Uses_Contact:
		if Contact_Zone.get_overlapping_bodies().size() > 0:
			Player.Health._DAMAGE(Enemy_Type.Contact_Damage)
	
	#starts the melee timer if the player enters the melee zone and the enemy has melee attacks enabled
	if Enemy_Type.Uses_Melee:
		if Melee_Zone.get_overlapping_bodies().size() > 0:
			if !Attacking:
				Melee_Timer.start()
				Attacking = true
	
	#applies the velocity to the position
	position += velocity
	move_and_slide()
	
#apply knockback to the enemy
func _KnockBack(Force:float = 0,pos:Vector2 = Vector2(0,0)):
	velocity += pos.direction_to(position) * Force/pos.distance_to(position)

#kills the enemy
func _death() -> void:
	queue_free()

#Attacks if player is in range and the enemy type is set to using Melee
func _on_melee_timeout() -> void:
	Attacking = false
	if Melee_Zone.get_overlapping_bodies().size() > 0:
		Player.Health._DAMAGE(Enemy_Type.Melee_Damage)
