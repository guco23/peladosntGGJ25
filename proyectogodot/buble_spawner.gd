extends Node2D

var bubles:PackedScene=preload("res://prefabs/Burbuja.tscn")
var gasThreshold: int= 2000

func SpawnBuble():
	var buble:Node2D = bubles.instantiate()
	get_parent().add_sibling(buble)
	buble.global_position = global_position


func _on_lata_gas_up(gasValue: Variant) -> void:
	if(gasValue > gasThreshold):
		SpawnBuble()
	pass # Replace with function body.
