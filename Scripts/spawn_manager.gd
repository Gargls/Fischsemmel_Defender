class_name enemy_spawner
extends Node2D

@export var enemy_scenes:PackedScene
@export var time_between_waves: float = 10.0
@export var enemies_per_wave: int = 4
@export var raise_difficulty_by:int = 1
@export var win_label:Label
@export var rounds_to_win:int = 5

@onready var spawn_area: Area2D = $SpawnArea
@onready var cooldown_waves: Timer = $Cooldown_Waves

var current_wave:int = 0
var wave_in_progress:bool = false

func _ready() -> void:
	start_next_wave()

func _process(delta: float) -> void:
	if current_wave >= rounds_to_win:
		winning()
	
	if wave_in_progress:
		cooldown_waves.stop()
		if get_tree().get_nodes_in_group("enemy").is_empty():
			wave_in_progress = false
			if cooldown_waves.is_stopped():
				cooldown_waves.start(time_between_waves)


func winning():
	print("Yay u won lol")
	win_label.show()
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	

func start_next_wave():
	current_wave += 1
	wave_in_progress = true
	
	print("start wave")
	
	for i in range(enemies_per_wave):
		spawn_enemy()
	
	enemies_per_wave += raise_difficulty_by
	
	
func spawn_enemy():
	if enemy_scenes == null:
		push_error("enemy_escenes empty")
		return
	
	var enemy_instance = enemy_scenes.instantiate()
	enemy_instance.global_position = get_random_loc_in_area()
	enemy_instance.add_to_group("enemy")
	get_tree().current_scene.add_child.call_deferred(enemy_instance)
	
func get_random_loc_in_area():
	var shape = spawn_area.get_node("CollisionShape2D").shape
	var extents: Vector2
	
	extents = shape.extents
	var local_position = Vector2(randf_range(-extents.x, extents.x), randf_range(-extents.y, extents.y))
	return spawn_area.to_global(local_position)
			

func _on_cooldown_waves_timeout() -> void:
	start_next_wave()
