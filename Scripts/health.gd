extends Node2D
class_name C_Health
signal _DEATH()

@export_category("Health")
@export var MAXHEALTH:float = 100
@export var HEALTH:float = 100
@export var DEFENCE:float = 0
@export var IMUNITY_FRAMES:int = 0

var FRAME:int = 0
var CAN_DAMAGE:bool = true
var DAMAGE_NUMBER_VELOCITY:Vector2 = Vector2(0,0)

@export_category("BAR")
@export var HAS_BAR:bool = true
@export var BAR_POS:Vector2 = Vector2(-8,-10)
@export var BAR_SIZE:Vector2 = Vector2(16,1)

#Updates the bar on load
func _ready() -> void:
	FRAME = IMUNITY_FRAMES
	_UPDATE_BAR()


func _physics_process(delta: float) -> void:
	#sets can damage to true after a certain amount of frames
	if FRAME > IMUNITY_FRAMES:
		CAN_DAMAGE = true
	else:
		CAN_DAMAGE = false
		FRAME += 1

#updates the values on the health bar
func _UPDATE_BAR():
	$HealthBar.visible = HAS_BAR
	$HealthBar.position = BAR_POS
	$HealthBar.size = BAR_SIZE
	$HealthBar.value = HEALTH

#applies damage to health and updates the bar
func _DAMAGE(DAMAGE:float = 0):
	if !CAN_DAMAGE:
		return
	FRAME = 0
	HEALTH -= DAMAGE - DEFENCE
	if HEALTH <= 0:
		HEALTH = 0
		emit_signal("_DEATH")
	CAN_DAMAGE = false
	_UPDATE_BAR()

#adds heal to HEALTH without going over MAXHEALTH and then updates bar
func _HEAL(HEAL:float = 0):
	HEALTH += HEAL
	if HEALTH > MAXHEALTH:
		HEALTH = MAXHEALTH
	_UPDATE_BAR()
