extends Node2D
@export var Test_Enemy:C_Enemy_Type_RE
@export var Amount:int = 100
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("TEST_ACTION"):
		$EnemySpawner._Add_Enimies(Amount,Test_Enemy)
	$Number.text = str(get_tree().get_nodes_in_group("Enemies").size())
