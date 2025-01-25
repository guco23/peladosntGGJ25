class_name frisby
extends RigidBody2D

@export var targetNode:Node2D 
@export var velocityModule:float
@export var lifeTime:float


var currLifeTime:float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	if targetNode == null:
		print_debug("Error en frisby, no hay targetnode")
		return		
	
	look_at(targetNode.position)
	
	var direction = Vector2(cos(rotation),sin(rotation))	
	
	linear_velocity = direction * velocityModule
	
	#print_debug("Direction:",direction)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	currLifeTime += delta
	
	if currLifeTime > lifeTime:
		queue_free()
		
	
	pass

func isInLayer(layerBody:int, layerTarget:int) -> bool:
	
	#print_debug("estoy aqui", layerBody,layerTarget)
	
	if layerBody & (1 << (layerTarget-1)):
		return true
	else:
		return false

func _on_body_entered(body:Node) -> void:
	
	if body is CollisionObject2D:
		if isInLayer(body.collision_layer,3):
			print_debug("he chocado con pared, destruccion")
			#queue_free()
		
	
	
	print_debug("he chocao")
	
	pass # Replace with function body.
