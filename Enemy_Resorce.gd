extends Resource
class_name C_Enemy_RE

@export_group("Stats")
@export var Damage:float = 10
@export var Max_Health:float = 100
@export var Speed:float = 0.05
@export var Defence:float = 0

@export_group("Collisions")
@export var Collision_Radius:float = 8
@export var Attack_Radius:float = 8
@export var Stop_Radius:float = 0

@export_group("Projectile")
@export var Uses_Projectile:bool = false
@export var Projectile:Projectile_RE

@export_group("")
@export var Animations:SpriteFrames
