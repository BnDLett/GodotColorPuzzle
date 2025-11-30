extends RichTextLabel

var attempts = 0
var format = "Attempt %d"


func _ready():
	text = format % attempts


func _on_verify_group_attempt() -> void:
	attempts += 1
	text = format % attempts
