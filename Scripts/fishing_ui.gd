extends MarginContainer

@onready var progress_bar: ProgressBar = %ProgressBar

const MIN_FISH_OK: float = 28.5
const MAX_FISH_OK: float = 70.7

func _process(delta: float) -> void:
	progress_bar.visible = Player.ref.is_fishing
