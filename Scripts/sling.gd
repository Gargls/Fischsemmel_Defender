extends Node2D

@export var inventory:Inventory
@export var proj_scene:PackedScene
@export var min_shot_force: float = 10.0
@export var max_shot_force: float = 600.0
@export var charge_time: float = 2.0

@onready var player:PlayerCharacter = get_tree().get_first_node_in_group("player")
@onready var preview_line: Line2D = $PreviewLine
@onready var nozzle: Node = $nozzle

var charging:bool = false
var charge_timer: float = 0.0
var ammo

## Shooting Mechanics

func start_charging():
	
	ammo = inventory.get_current_ammo()
	if ammo == null:
		print("No Ammo Selected!")
		
	else:
		charging = true
		charge_timer = 0.0


func release_shot():
	if charging:
		charging = false
		var t = charge_timer / charge_time
		var final_force = lerp(min_shot_force, max_shot_force, t)
		if final_force >= 75:
			var proj_scene:PackedScene = ammo
			var proj = proj_scene.instantiate()
			var dir = (get_global_mouse_position() - nozzle.global_position).normalized()
			proj.velocity = dir * final_force
			proj.spawn_position = nozzle.global_position
			proj.spawn_rotation = nozzle.global_rotation
			#proj.projectile_speed_mult = final_force / 150
			proj.max_range = final_force
			get_tree().current_scene.add_child(proj)
			clear_preview()
			ammo = inventory.use_ammo()
			if ammo == null:
				print_debug("What just happened? Invenrtory Ammo is null")
		else:
			clear_preview()
			pass
		
func update_preview(force: float):
	var start = to_local(global_position)
	var dir = (to_local(get_global_mouse_position()) - start).normalized()
	var points = []

	var step_size = 20.0 
	var steps = int((force * 1.2)  / step_size) 
	for i in range(steps):
		points.append(start + dir * (i * step_size))

	preview_line.points = points

func clear_preview():
	preview_line.points = []


func _physics_process(delta: float) -> void:

	if charging:
		charge_timer = min(charge_timer + delta, charge_time)
		var t = charge_timer / charge_time
		var current_force = lerp(min_shot_force, max_shot_force, t)
		update_preview(current_force)
		
	if Input.is_action_just_pressed("shoot"):
		print("click")
		start_charging()
		player.move_speed *= 0.2
	if Input.is_action_just_released("shoot"):
		release_shot()
		player.move_speed *= 5.0  
