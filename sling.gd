extends Node2D

@export var proj_scene:PackedScene
@onready var nozzle: Node = $nozzle


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		var proj = proj_scene.instantiate()
		proj as projectile
		
		proj.spawn_position = nozzle.global_position
		proj.spawn_rotation = nozzle.global_rotation
		
		get_tree().current_scene.add_child(proj)
