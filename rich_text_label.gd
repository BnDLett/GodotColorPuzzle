extends RichTextLabel

func _ready():
	visible = false


func _on_verify_group_game_win() -> void:
	visible = true
