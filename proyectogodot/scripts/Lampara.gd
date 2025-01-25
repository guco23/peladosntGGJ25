extends RigidBody2D

var pinned = true


var isActive:bool = false

func Fall():
	if pinned:
		freeze = false
		isActive = true
		pinned = false
		

func _process(delta: float) -> void:
	
	
	set_collision_mask_value(4,isActive)
	set_collision_layer_value(3,isActive)
	
	

func _on_body_entered(body: Node) -> void:
	
	
	if body is CollisionObject2D:
		
		if body.get_collision_layer_value(2): #colision con el suelo
			isActive = false
			
			#lanzar animacion
			$Sprite2D.play()
			#print_debug("desactivado")
			
	
	
	pass # Replace with function body.


func _on_sprite_2d_animation_finished() -> void:
	
	print_debug("aniamcionTerminada")
	
	pass # Replace with function body.


func _on_sprite_2d_animation_looped() -> void:
	
	print_debug("aniamcionTerminada loop")
	
	queue_free()
	
	pass # Replace with function body.
