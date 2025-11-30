class_name ColorGroup
extends Node2D

@export var current_color = null

static var BLUE = Color("#2a62d2")
static var YELLOW = Color("#f9c124")
static var RED = Color("#f52b5b")
static var colors = [BLUE, YELLOW, RED]

var color_node: MeshInstance2D = null
var down_cnode: MeshInstance2D = null
var up_cnode: MeshInstance2D = null

var color_index = 0

signal color_updated

func _ready():
	var down_button = get_node("DownButton/Button")
	var up_button = get_node("UpButton/Button")
	
	color_node = get_node("Color")
	down_cnode = get_node("DownButton/Color")
	up_cnode = get_node("UpButton/Color")
	
	update_color(99)
	
	down_button.connect("pressed", down_button_pressed)
	up_button.connect("pressed", up_button_pressed)

func update_color(step: int):
	color_index += step
	var color = colors[abs(color_index % len(colors))]
	
	current_color = color
	color_node.modulate = color
	down_cnode.modulate = colors[abs((color_index - 1) % len(colors))]
	up_cnode.modulate = colors[abs((color_index + 1) % len(colors))]
	
	color_updated.emit()

func down_button_pressed():
	update_color(-1)

func up_button_pressed():
	update_color(1)
