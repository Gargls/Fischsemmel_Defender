class_name projectile
extends Area2D

@export var projectile_speed:float = 500.0
@export var projectile_time:float = 3
@export var projectile_damage:int = 1
@export var projectile_knockback:float = 50
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
	print(body)
	if body.is_in_group("enemy"):
		body.hurt(projectile_damage, projectile_knockback, global_position)
		print("hurt!")
		queue_free()
