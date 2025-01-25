extends Node

const TIME_OVER = 5
var agitation : int
var gasThreshold: int = 2000
var isCokeDragging: bool = false
var game_time : int

var gameOver : bool
var overCounter : float
var inGame : bool

func _ready() -> void:
	overCounter = 0
	game_time = 0
	agitation = 0 
	inGame = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if gameOver:
		overCounter += delta
		if overCounter >= TIME_OVER:
			endGame()
	elif inGame:
		game_time += delta  # Suma el tiempo transcurrido


func lost():
	if !gameOver:
		overCounter = 0
		gameOver = true
		print_debug("lost")


func startGame():
	game_time = 0
	inGame = true
	get_tree().change_scene_to_file("res://scenes/MainScene.tscn")

func endGame():
	inGame = false
	gameOver = false
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
