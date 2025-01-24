class_name discoController
extends RigidBody2D

@export var minInitialVelX:float = 100
@export var maxInitialVelX:float = 150

@export var minInitialVelY:float = 100
@export var maxInitialVelY:float = 150

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	#print_debug("primer tu vieja")
	#print_debug(linear_velocity)
	
	var initialVelX = randf_range(minInitialVelX,maxInitialVelX)
	var initialVelY = randf_range(minInitialVelY,maxInitialVelY)
	
	linear_velocity = Vector2(initialVelX,initialVelY)
	#print_debug("DiscoInitalVel-> ", "X:",initialVelX, " Y:",initialVelY)
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#print_debug(linear_velocity.x,linear_velocity.y)
	
	
	pass
