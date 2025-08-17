extends Node2D

@onready var press_e: Label = $Area2D/PRESS_E
@onready var inventory: Inventory = $PlayerCharacter/inventory
var is_at_trash:bool
@onready var press_e_2: Label = $Area2D2/PRESS_E_2
@onready var trash_rummage: AudioStreamPlayer2D = $trash_rummage



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_at_trash = true
		press_e.show()
		press_e_2.show()
		
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") && is_at_trash:
		trash_rummage.play()
		inventory.add_ammo(inventory.ammo_array.pick_random())
		print("add ammo")



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_at_trash = false
		press_e.hide()
		press_e_2.hide()
