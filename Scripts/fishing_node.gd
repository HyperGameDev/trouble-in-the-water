extends Area3D

@onready var mesh: MeshInstance3D = $MeshInstance3D

@onready var label_fish: Label3D = %Label_Fish
var is_being_fished: bool = false

func _ready() -> void:
	mesh.visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func fishing_state(active:bool) -> void:
	is_being_fished = active
	
	if active:
		label_visibility(false)
	
func label_visibility(show_label:bool) -> void:
	label_fish.visible = show_label

func _on_body_entered(body) -> void:
	if body is CharacterBody3D and not is_being_fished:
		body.can_fish = true
		body.current_node = self
		label_visibility(true)
		
func _on_body_exited(body) -> void:
	if body is CharacterBody3D and not is_being_fished:
		body.can_fish = false
		body.current_node = null
		label_visibility(false)
