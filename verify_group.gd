extends Node2D

var colors_node: Node2D
var color_groups: Array[ColorGroup]
var correct_answers: Array[Color]
var timer: Timer
var result_label: RichTextLabel


signal game_win
signal attempt


func generate_answer(count: int):
	var shuffle_array: Array = ColorGroup.colors.duplicate(true)
	var answers: Array[Color]

	for i in range(count):
		shuffle_array.shuffle()
		answers.append(shuffle_array[0])
	
	correct_answers = answers


func check_answer() -> int:
	var correct_counter = 0
	
	for i in range(len(color_groups)) :
		var attempt = color_groups[i]
		var answer = correct_answers[i]

		if attempt.current_color == answer:
			correct_counter += 1
	
	return correct_counter


func update_color_groups():
	var lookup_result = colors_node.find_children("Color*", "ColorGroup", false)
	
	for result in lookup_result:
		if result is not Node2D:
			continue
		
		color_groups.append(result as ColorGroup)


func _on_colors_ready() -> void:
	result_label = get_node("ResultLabel")
	timer = get_node("VerifyButton/Timer")
	colors_node = get_parent().get_node("Colors")
	update_color_groups()
	generate_answer(len(color_groups))


func _on_button_pressed() -> void:
	result_label.text = "Calculating..."
	attempt.emit()
	timer.start()


func _on_timer_timeout() -> void:
	var correct_count = check_answer()
	result_label.text = "%d colors are correct." % correct_count
	
	if correct_count == len(correct_answers):
		game_win.emit()
