extends Node

var score : int
var difficulty : int
var agitation : int
var gasThreshold: int = 2000
var isCokeDragging: bool = false

func _ready() -> void:
	score = 0
	difficulty = 0
	agitation = 0 
