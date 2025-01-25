extends Node

var agitation : int

var isCokeDragging: bool = false
var game_time : int

func _ready() -> void:
	agitation = 0 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	game_time += delta  # Suma el tiempo transcurrido

func restartTime():
	game_time = 0
