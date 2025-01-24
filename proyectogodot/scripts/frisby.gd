class_name frisby
extends RigidBody2D

@export var targetNode:Node2D 
@export var velocityModule:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	if targetNode == null:
		print_debug("Error en frisby, no hay targetnode")
		return		
	
	look_at(targetNode.position)
	
	var direction = Vector2(cos(rotation),sin(rotation))	
	
	linear_velocity = direction * velocityModule
	
	print_debug("Direction:",direction)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	
	
	
	pass
