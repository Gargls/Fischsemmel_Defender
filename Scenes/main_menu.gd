extends Control

@onready var controls: TextureRect = $Controls
@export var start_menu:PackedScene



func _on_options_toggled(toggled_on: bool) -> void:
	print(toggled_on)
	if toggled_on: 
		controls.show()
	else:
		controls.hide()


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://TEST/testlevel.tscn")
	

func _on_exit_pressed() -> void:
	get_tree().quit()
