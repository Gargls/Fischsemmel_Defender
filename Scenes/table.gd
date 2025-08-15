extends Node2D

var life:int = 5

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		take_damage(body.damage)
		body.queue_free()

func take_damage(damage:int=1):
	life -= damage
	if life <= 0:
		get_tree().quit()
