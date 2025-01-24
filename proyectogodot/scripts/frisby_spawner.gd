class_name FrisbySpawner
extends Node2D

const FRISBY:PackedScene = preload("res://prefabs/frisby.tscn")
@export var target:Node2D 

@export var minSpawnTime:float = 2
@export var maxSpawnTime:float = 3

var spawnTime:float = 0
var spawnTimeCounter = 0


func spawnFrisby():
	
	
	var newFrisby = FRISBY.instantiate()
	
	newFrisby.position = Vector2(0,0)
	newFrisby.targetNode = target
	
	add_child(newFrisby)
	
	print_debug("frisby instanciado")
	
	pass
	
	
func calcultateNewSpawnTime():
	spawnTime = randf_range(minSpawnTime,maxSpawnTime)
	spawnTimeCounter = 0
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	spawnTimeCounter += delta
	
	if spawnTimeCounter > spawnTime:
		spawnFrisby()
		calcultateNewSpawnTime()
		
		
	
	pass
