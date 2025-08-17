extends Area2D

@export var ammo_type: AmmoResource

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.inventory.add_ammo(ammo_type)
		queue_free()
		
