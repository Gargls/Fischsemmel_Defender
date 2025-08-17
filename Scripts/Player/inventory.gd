class_name Inventory
extends Node

@export var MAX_SLOTS = 5
var slots: Array[PackedScene] = [null, null, null, null, null]
var current_slot: int = 0

@onready var ammo_array: Array[PackedScene] = []
var scene_folder:String = "res://Scenes/Player/projectiles/"

func _ready() -> void:
	load_scenes_from_folder()
	
func load_scenes_from_folder():
	ammo_array.clear()
	var dir = DirAccess.open(scene_folder)

	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if file_name.ends_with(".tscn"):
				var scene_path = scene_folder + file_name
				var scene = load(scene_path)
				if scene is PackedScene:
					ammo_array.append(scene)
			file_name = dir.get_next()
		
		print("Loaded scenes:", ammo_array.size())
	else:
		print("Failed to open folder:", scene_folder)


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("cycle_next"):
		cycle_next()
	
	if Input.is_action_just_pressed("cycle_previous"):
		cycle_previous()
	
	if Input.is_action_just_pressed("debug_1"):
		var random_ammo = ammo_array.pick_random()
		add_ammo(random_ammo)
		print("Added: ", random_ammo.resource_name)
		random_ammo = null
	
		
		cycle_next()
		print(slots)
		

func add_ammo(ammo) -> bool:
	for i in range(MAX_SLOTS):
		if slots[i] == null:
			slots[i] = ammo
			return true
	return false #if full
	
func use_ammo():
	var ammo = slots[current_slot]
	if ammo == null:
		return null
	slots[current_slot] = null
	
	cycle_next()
	
	return ammo
	
func cycle_next():
		print("bla2")
		var start_slot = current_slot
		while true:
			current_slot = (current_slot + 1) % MAX_SLOTS
			if slots[current_slot] != null:
				break
			if current_slot == start_slot:
				break

func cycle_previous():
		print("bla1")
		var start_slot = current_slot
		while true:
			current_slot = (current_slot - 1 + MAX_SLOTS) % MAX_SLOTS
			if slots[current_slot] != null:
				break
			if current_slot == start_slot:
				break

func get_current_ammo():
	return slots[current_slot]
