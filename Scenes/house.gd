extends Node3D
@onready var area: Area3D = %Area3D
@onready var label: Label3D = %Label_

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)
	
func _input(event: InputEvent) -> void:
	if label.visible == true and Monster.ref.is_chasing:
		if Input.is_action_just_pressed("Action"):
			%TextureRect.visible = true 
			Player.ref.in_house = true
			Monster.ref.is_caught = false
			Monster.ref.is_chasing = false
			await get_tree().create_timer(2.).timeout
			%TextureRect.visible = false
			Player.ref.in_house = false
			

func _on_body_entered(body) -> void:
	if body is Player:
		label.visible=true
func _on_body_exited(body) -> void:
	if body is Player:
		label.visible = false
		
