
class_name enemy
extends CharacterBody2D

@export var life:int = 10
@export var move_speed:float = 200.0
var target:Node2D
var knockback_velocity:Vector2 = Vector2.ZERO
var knockback_decay:float = 400

func _physics_process(delta: float) -> void:
	target = get_tree().get_first_node_in_group("Table")
	
	if target != null:
		move_to_target()
	
	knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, knockback_decay * delta)
	
	
func move_to_target():
	var direction = (target.position - position).normalized()
	look_at(target.position)
	velocity = direction * move_speed
	move_and_slide()
	
func hurt(damage:int=1, knockback_force:float=50, hit_origin:Vector2=Vector2.ZERO):
	life -= damage
	var knockback_direction = (position - hit_origin).normalized()
	knockback_velocity = knockback_direction * knockback_force
	if life <= 0:
		queue_free()
	
