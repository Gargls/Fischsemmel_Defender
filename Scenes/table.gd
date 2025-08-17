extends Node2D

@export var life:int = 5
@onready var life_counter: TextureProgressBar = $"../Life/TextureProgressBar"
@export var main_menu: PackedScene
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		take_damage(body.damage)
		body.queue_free()

func take_damage(damage:int=1):

	life -= damage
	life_counter.value = life
	audio_stream_player_2d.play()
	await audio_stream_player_2d.finished
	if life <= 0:
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
