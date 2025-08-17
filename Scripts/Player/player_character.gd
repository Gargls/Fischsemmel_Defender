class_name PlayerCharacter
extends CharacterBody2D

@export var move_speed: float = 200

func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var direction_to_mouse = mouse_pos - global_position
	rotation = direction_to_mouse.angle()
	
func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
	
	input_vector = input_vector.normalized()
	velocity = input_vector * move_speed
	move_and_slide()
