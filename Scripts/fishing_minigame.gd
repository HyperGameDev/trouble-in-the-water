extends MarginContainer

@onready var progress_bar: ProgressBar = %ProgressBar
@onready var monster: Node3D = %monster

const MIN_FISH_OK: float = 28.5
const MAX_FISH_OK: float = 70.7


func _process(delta: float) -> void:
	progress_bar.visible = Player.ref.is_fishing
	
	if OS.is_debug_build():
		if Input.is_action_just_pressed("Debug_1"):
			roll_rand_bool()
		if Input.is_action_just_pressed("Debug_0"):
			_minigame_won(false)

	if Player.ref.is_fishing:
		_dec_progress(delta)
		if Input.is_action_just_pressed("Action"):
			_inc_progress()
		if progress_bar.value >= 100.:
			roll_rand_bool()

func roll_rand_bool() -> void:
	var rand_bool: bool = randi_range(0,100) > 20
	_minigame_won(rand_bool)
			
func _inc_progress() -> void:
	progress_bar.value += 8.
		
func _dec_progress(delta:float) -> void:
	progress_bar.value -= 30. * delta

func _minigame_won(is_fish:bool) -> void:
	Player.ref.is_fishing = false
	Player.ref.current_node.is_being_fished = false
	progress_bar.value = 35.
	if is_fish:
		UI.ref.fish_caught += 1
	else:
		monster.global_position = Vector3(Player.ref.current_node.global_position.x,Player.ref.global_position.y,Player.ref.current_node.global_position.z)
		monster.is_caught = true
	Player.ref.waiting = true
	await get_tree().create_timer(1.5).timeout
	Player.ref.waiting = false
	
		
