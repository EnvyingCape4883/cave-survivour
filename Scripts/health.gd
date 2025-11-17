extends Node2D

signal _DEATH()

@export_category("Health")
@export var MAXHEALTH:float = 100
@export var HEALTH:float = 100

@export_category("BAR")
@export var HAS_BAR:bool = true
@export var BAR_POS:Vector2 = Vector2(-8,-10)
@export var BAR_SIZE:Vector2 = Vector2(16,1)

#Updates the bar on load
func _ready() -> void:
	_UPDATE_BAR()

#updates the values on the health bar
func _UPDATE_BAR():
	$HealthBar.visible = HAS_BAR
	$HealthBar.position = BAR_POS
	$HealthBar.size = BAR_SIZE
	$HealthBar.value = HEALTH

#applies damage to health and updates the bar
func _DAMAGE(DAMAGE:float = 0):
	HEALTH -= DAMAGE
	if HEALTH <= 0:
		HEALTH = 0
		emit_signal("_DEATH")
	_UPDATE_BAR()

#adds heal to HEALTH without going over MAXHEALTH and then updates bar
func _HEAL(HEAL:float = 0):
	HEALTH += HEAL
	if HEALTH > MAXHEALTH:
		HEALTH = MAXHEALTH
	_UPDATE_BAR()
