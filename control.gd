extends Control

@onready var wave_counter: Label = $"VBoxContainer/Wave Counter"
@onready var timer: Label = $VBoxContainer/Timer
@onready var spawn_manager:enemy_spawner = get_tree().get_first_node_in_group("spawner")
@onready var table := get_tree().get_first_node_in_group("Table")
@onready var in_progress: Label = $VBoxContainer/in_progress
@onready var life: Label = $VBoxContainer/life

func _physics_process(delta: float) -> void:
	
	#if spawn_manager != null:
		#print(spawn_manager.current_wave)
	wave_counter.text = str(spawn_manager.current_wave)
	timer.text = str(spawn_manager.cooldown_waves.time_left).pad_decimals(2)
	in_progress.text = str("In Progress: ", spawn_manager.wave_in_progress)
	life.text = str("Current Life: ", table.life)
