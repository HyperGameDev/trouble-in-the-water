class_name UI extends CanvasLayer

static var ref: CanvasLayer

@onready var label_fish_count: Label = %Label_Fish_Count
@onready var label_game_over: Label = %label_game_over

var fish_caught: int = 0:
	set(value):
		fish_caught = value
		label_fish_count.text = str(fish_caught)

func _init() -> void:
	ref = self
	
