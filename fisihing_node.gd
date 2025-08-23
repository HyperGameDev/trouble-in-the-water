extends Area3D

@onready var label_fish: Label3D = %Label_Fish

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body) -> void:
	if body is CharacterBody3D:
		body.can_fish = true
		body.current_node = self
		label_fish.visible = true
		
func _on_body_exited(body) -> void:
	if body is CharacterBody3D:
		body.can_fish = false
		body.current_node = null
		label_fish.visible = false
