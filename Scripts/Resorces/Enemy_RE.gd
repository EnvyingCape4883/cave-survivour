extends Resource
class_name C_Enemy_Type_RE

@export_group("Stats")
@export var Max_Health:float = 100
@export var Speed:float = 0.05
@export var Defence:float = 0

@export_group("Collisions")
@export var Collision_Radius:float = 8
@export var Stop_Radius:float = 0

@export_group("DamageType")

@export_subgroup("Contact")
@export var Uses_Contact:bool = true
@export var Contact_Damage:float = 2

@export_subgroup("Melee")
@export var Uses_Melee:bool = false
@export var Melee_Shape:Shape2D = load("res://Scripts/Resorces/DefualtMeleeShape.tres")
@export var Melee_Shape_Pos:Vector2 = Vector2(14,0)
@export var Melee_Rate = 1
@export var Melee_Damage:float = 10

@export_subgroup("Projectile")
@export var Projectile:Projectile_RE

@export_group("")
@export var Animations:SpriteFrames
