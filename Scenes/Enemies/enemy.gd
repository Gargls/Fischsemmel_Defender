
class_name enemy
extends CharacterBody2D

@export var life:int = 10
@export var move_speed:float = 200.0
@export var damage:int = 1
var target:Node2D
var knockback:Vector2 = Vector2.ZERO
var knockback_timer:float = 0.0

func _physics_process(delta: float) -> void:
	target = get_tree().get_first_node_in_group("Table")
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= delta
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO
	else:
		_move(delta)
	move_and_slide()
func _move(delta):
	if target != null:
		move_to_target()
	

	
	
func move_to_target():
	var direction = (target.position - position).normalized()
	look_at(target.position)
	velocity = direction * move_speed
	
func hurt(damage:int=1):
	life -= damage
	print(self, life)
	if life <= 0:
		queue_free()

func apply_knockback(direction:Vector2, kb_force:float, kb_duration:float) -> void:
	knockback = direction * kb_force
	knockback_timer = kb_duration
	
