extends CharacterBody2D
class_name C_Enemy_Base

#customizeble values to speed up testing
@export var Enemy_Type:C_Enemy_RE

var Attacking:bool = false
var Stopping:bool = false

#references
@onready var Health:C_Health = $Health
@onready var Player:C_Player = get_tree().get_first_node_in_group("Player")
@onready var Attack_Shape:CircleShape2D = $AttackZone/CollisionShape2D.shape
@onready var Stop_Shape:CircleShape2D = $AttackZone/CollisionShape2D.shape
@onready var Anim_Sprite:AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	Health.MAXHEALTH = Enemy_Type.Max_Health
	Health.DEFENCE = Enemy_Type.Defence
	Attack_Shape.radius = Enemy_Type.Attack_Radius
	Stop_Shape.radius = Enemy_Type.Stop_Radius
	#Anim_Sprite.sprite_frames = Enemy_Type.Animations

#is true if the player is in the attacking radius
var Player_In:bool = false

func _process(delta: float) -> void:
	#reduces the velocity to slow movement overtime
	velocity *= 0.9
	
	#adds velocity in the direction to the player
	if !Stopping:
		velocity += position.direction_to(Player.position).normalized() * Enemy_Type.Speed
	
	#applies the velocity to the position
	position += velocity
	
	#attack the player once in the attack zone
	if Attacking:
		Player.Health._DAMAGE(Enemy_Type.Damage)
	move_and_slide()

func _KnockBack(Force:float = 0,pos:Vector2 = Vector2(0,0)):
	velocity += pos.direction_to(position) * Force/pos.distance_to(position)

func _death() -> void:
	queue_free()

#Checks If the player enters the Attack Zone
func _On_Entered_Attack_Zone(body: Node2D) -> void:
	if body == Player:
		Attacking = true

#Checks If the player Exits the Attack Zone
func _on_Exited_Attack_Zone(body: Node2D) -> void:
	if body == Player:
		Attacking = false

#Checks If the player enters the Stop Zone
func _On_Entered_Stop_Zone(body: Node2D) -> void:
	if body == Player:
		Stopping = true

#Checks If the player Exits the Stop Zone
func _On_Exited_Stop_Zone(body: Node2D) -> void:
	if body == Player:
		Stopping = false
