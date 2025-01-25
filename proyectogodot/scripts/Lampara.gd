extends RigidBody2D

var pinned = true


var isActive:bool = false

func Fall():
	if pinned:
		freeze = false
		isActive = true
		pinned = false
		

func _process(delta: float) -> void:
	
	print_debug(get_collision_mask_value(4))
	
	set_collision_mask_value(4,isActive)
	set_collision_layer_value(3,isActive)
	
	

func _on_body_entered(body: Node) -> void:
	
	
	print_debug(body.name)
	
	
	if body is CollisionObject2D:
		print_debug(body.get_collision_layer_value(2))
		
		if body.get_collision_layer_value(2): #colision con el suelo
			isActive = false
			
			print_debug("desactivado")
			
			#lanzar animacion
	
	
	pass # Replace with function body.
