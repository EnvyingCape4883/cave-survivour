extends Area2D
class_name C_Projectile

var velocity:Vector2 = Vector2(0,0)

var Projectile_Type:C_Projectile_Type_RE
var Target_Node:CharacterBody2D

var Target:String = "Player"

var Pierce:int = 0
var Bounce:int = 0

@onready var Life_Timer:Timer = $LifeTime
@onready var Shape_Cast:ShapeCast2D
@onready var Anim_Sprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var Collision_Shape:CollisionShape2D = $CollisionShape2D
@onready var Player:C_Player = get_tree().get_first_node_in_group("Player")

func _ready() -> void:
	Bounce = Projectile_Type.Bounce
	Pierce = Projectile_Type.Pierce
	Life_Timer.wait_time = Projectile_Type.Life_Time
	Collision_Shape.shape.radius = Projectile_Type.Size
	Anim_Sprite.sprite_frames = Projectile_Type.Sprite_Frames
	
	if Target == "Player":
		set_collision_mask_value(2,true)
		set_collision_mask_value(3,false)
		Target_Node = Player
	elif Target == "Enemy":
		set_collision_mask_value(2,false)
		set_collision_mask_value(3,true)
		_Get_Closest_Enemy()
	else:
		queue_free()
	if !Target_Node:
		queue_free()
		return
	velocity = position.direction_to(Target_Node.position).normalized() * Projectile_Type.Speed

func _process(delta: float) -> void:
	if !Target_Node:
		queue_free()
		return
	if Projectile_Type.Homing:
		velocity = position.direction_to(Target_Node.position).normalized() * Projectile_Type.Speed
	
	velocity *= Projectile_Type.Acceleration
	position += velocity

func _Get_Closest_Enemy(Filter:CharacterBody2D = null):
	var Nearest_Node:CharacterBody2D = null
	var Nearest_Distance:float = INF
	for i in get_tree().get_node_count_in_group("Enemy"):
		if get_tree().get_nodes_in_group("Enemy")[i] != Filter:
			if Nearest_Distance > position.direction_to(get_tree().get_nodes_in_group("Enemy")[i].position).length():
				Nearest_Distance = position.direction_to(get_tree().get_nodes_in_group("Enemy")[i].position).length()
				Nearest_Node = get_tree().get_nodes_in_group("Enemy")[i]
	if Nearest_Node:
		Target_Node = Nearest_Node
		velocity = position.direction_to(Target_Node.position).normalized() * Projectile_Type.Speed
	else:
		queue_free()

func _on_life_time_timeout() -> void:
	if Life_Timer.wait_time != 0:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	body.Health._DAMAGE(Projectile_Type.Damage)
	if Bounce >= 1:
		Bounce -= 1
		_Get_Closest_Enemy(body)
		return
	if Pierce >= 1:
		Pierce -= 1
		return
	queue_free()
