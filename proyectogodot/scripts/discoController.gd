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


func isInLayer(layerBody:int, layerTarget:int) -> bool:
	
	#print_debug("estoy aqui", layerBody,layerTarget)
	
	if layerBody & (1 << (layerTarget-1)):
		return true
	else:
		return false

func getRandomColor()->Color:
	
	return Color(randi_range(0,1),randi_range(0,1),randi_range(0,1),1)
	
	


func _on_body_entered(body: Node) -> void:
	if body is CollisionObject2D:
		if isInLayer(body.collision_layer,2):
			
			var lastColor = $Sprite2D.modulate
			var nextColor = getRandomColor()
			
			while nextColor == lastColor or nextColor == Color(0,0,0,1) or nextColor == Color(1,1,1,1):
				nextColor = getRandomColor()
			
			$Sprite2D.modulate = nextColor
	
	
	pass # Replace with function body.
