extends CanvasLayer

@export var inventory_node_path: NodePath
@onready var inventory = get_node(inventory_node_path)
@onready var slots = []
@onready var h_box_container: HBoxContainer = $HBoxContainer

func _ready():
	
	slots = h_box_container.get_children()

func _physics_process(delta: float) -> void:
	update_slots()

func update_slots():
	for i in range(slots.size()):
		var slot = slots[i] as TextureRect
		var ammo_scene = inventory.slots[i]

		# --- background for each slot ---
		slot.self_modulate = Color(0.7, 0.7, 0.7, 1) # grey base color

		if ammo_scene != null:
			var ammo_instance = ammo_scene.instantiate()
			# assuming stats.sprite is a Texture2D
			var sprite_texture: Texture2D = ammo_instance.stats.sprite
			slot.texture = sprite_texture
			slot.modulate = Color(1, 1, 1, 1)
			ammo_instance.queue_free()
		else:
			slot.texture = null
			slot.modulate = Color(1, 1, 1, 0.3) # faded look

		if i == inventory.current_slot:
			slot.scale = Vector2(1.2, 1.2) # slightly bigger
		else:
			slot.scale = Vector2(1, 1)
