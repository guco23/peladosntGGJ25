class_name FrisbySpawner
extends Node2D

const FRISBY:PackedScene = preload("res://prefabs/frisby.tscn")
@export var target:Node2D 

@export var minSpawnTime:float = 2
@export var maxSpawnTime:float = 3
@export var velocityModule:float = 450

var spawnTime:float = 0
var spawnTimeCounter = 0


func getFrisbySpawnPosition(corner:int) -> Vector2:
	
	if corner == 0:
		return Vector2(0,0)
	elif corner == 1: 
		return Vector2(get_viewport().size.x,0)
	elif corner == 2: 
		return Vector2(0,get_viewport().size.y)
	elif corner == 3: 
		return Vector2(get_viewport().size.x,get_viewport().size.y)
	else: 
		return Vector2(-1,-1)
	

func spawnFrisby():
	
	var newFrisby = FRISBY.instantiate()
	
	var corner =  randi()%4
	
		
	newFrisby.position = getFrisbySpawnPosition(corner)
	newFrisby.targetNode = target
	newFrisby.velocityModule = velocityModule
	
	
	add_child(newFrisby)
	
	#print_debug("frisby instanciado")
	
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
