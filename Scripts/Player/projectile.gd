class_name projectile
extends Area2D

@export var projectile_speed:float = 1.0
@export var projectile_time:float = 3
@export var projectile_damage:int = 1
@export var projectile_knockback:float = 50
@export var knockback_duration:float = 0.5
@onready var proj_timer: Timer = $proj_timer

var direction:float
var spawn_position:Vector2
var spawn_rotation:float

func _ready() -> void:
	proj_timer.start(projectile_time)
	global_position = spawn_position
	global_rotation = spawn_rotation

func _physics_process(delta: float) -> void:
	
	position += -transform.y * projectile_speed * delta
	


func _on_proj_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		var knockback_direction = (body.global_position - position).normalized()
		body.hurt(projectile_damage)
		body.apply_knockback(knockback_direction, projectile_knockback, knockback_duration)
		print("hurt!")
		queue_free()
