class_name projectile
extends Area2D

@export var stats: AmmoResource
@export var projectile_time:float = 3.0
@onready var proj_timer: Timer = $proj_timer
@onready var sprite_2d: Sprite2D = $Sprite2D

var sprite:Texture
var direction:float
var spawn_position:Vector2
var spawn_rotation:float
var velocity: Vector2
var distance_travelled: float = 0.0
var max_range:float = 600

func _ready() -> void:
	proj_timer.start(projectile_time)
	global_position = spawn_position
	global_rotation = spawn_rotation
	sprite = stats.sprite
	sprite_2d.texture = stats.sprite


func _physics_process(delta):
	var step = velocity * delta * stats.speed_mult
	global_position += step
	distance_travelled += step.length()

	if distance_travelled >= max_range:
		queue_free()


func _on_proj_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		var knockback_direction = (body.global_position - position).normalized()
		body.hurt(stats.damage)
		print(stats.damage, " Damage Applied")
		body.apply_knockback(knockback_direction, stats.knockback, 1)
		print("hurt!")
		queue_free()
