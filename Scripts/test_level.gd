extends Node2D
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("TEST_ACTION"):
		$Player/EnemySpawner._Add_Enemies(1)
		pass
