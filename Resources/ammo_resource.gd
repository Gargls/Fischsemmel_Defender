class_name AmmoResource
extends Resource

@export var name: String
@export var sprite: Texture2D

@export_group("Stats")
@export var damage: int
@export var speed_mult: float = 1
@export var max_range: float=100


@export_group("Stun&Knockback")
@export var stun:bool
@export var stun_duration: float=1
@export var knockback: float
