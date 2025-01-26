extends Node2D

var bubles:PackedScene=preload("res://prefabs/Burbuja.tscn")
var gen:RandomNumberGenerator
var can:Lata
var timer:Timer
@export var offsetChance:Vector2


var gasV:float

func _ready() -> void:
	gen = RandomNumberGenerator.new()
	can = get_parent()
	timer = get_node("Timer")

func SpawnBuble():
	var buble:Node2D = bubles.instantiate()
	get_parent().add_sibling(buble)
	var aux = Vector2(gen.randf_range(-offsetChance.x,offsetChance.x),gen.randf_range(-offsetChance.y,offsetChance.y))
	buble.global_position = global_position+aux

func _on_lata_gas_up(gasValue: Variant) -> void:
	
	gasV = gasValue
	
	#sacar burbujas cuando se va agitando

	if(gasValue > GameManager.gasThreshold*can.tier1 and timer.is_stopped()):
		timer.wait_time = 0.4
		timer.start()
	
	
		
	#sacar burbujas al final	
	if(gasValue > GameManager.gasThreshold):
		for i in range(2):
			SpawnBuble()
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	$AudioStreamPlayer2D.play()
	SpawnBuble()
	
	if gasV > GameManager.gasThreshold*can.tier2:
		timer.wait_time = 0.2
	
	timer.start()
	pass # Replace with function body.
