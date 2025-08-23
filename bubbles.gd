extends Node3D

@onready var animation: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation.play("ArmatureAction")
	
