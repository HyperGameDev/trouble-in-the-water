class_name Monster extends Node3D

static var ref: Node3D

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var area: Area3D = %Area3D

var is_chasing: bool = false

var is_caught: bool = false

func _init() -> void:
	ref = self

func _ready() -> void:
	area.body_exited.connect(_on_body_exited)
	animation.play("ArmatureAction")
	
func _process(delta: float) -> void:
	visible = is_caught
	if is_caught:
		look_at(Player.ref.global_position,Vector3(0,1,0))
		
		#var new_pos: Vector3 = global_position.move_toward(Player.ref.global_position,2000*delta)
		var new_pos: Vector3 = lerp(global_position,Player.ref.global_position,.01)
		global_position = new_pos
		print(new_pos)
		
	
		var distance_raw: Vector3 = Player.ref.global_position - global_position
		
		var distance: float = distance_raw.length()
		
		print(distance)
		
		if is_chasing:
			if distance < 5.:
				lose_game()
			if distance <= 0.5:
				get_tree().reload_current_scene()
		else:
			if distance <= 0.8:
				lose_game()
				await get_tree().create_timer(3.).timeout
				get_tree().reload_current_scene()
			

func lose_game() -> void:
	UI.ref.label_game_over.visible = true
	Player.ref.game_over = true
	
func _on_body_exited(body) -> void:
	if body.name == "Lake":
		is_chasing = true
