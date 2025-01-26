extends RigidBody2D

var gen:RandomNumberGenerator
var canSound:AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gen = RandomNumberGenerator.new()
	canSound = get_node("AudioStreamPlayer")
	contact_monitor = true
	
	pass # Replace with function body.


func releaseCan():
	
	GameManager.isCokeDragging = false
	#ajustar velocidades 
	linear_velocity = Vector2.ZERO
	angular_velocity = gen.randf_range(-0.3,0.3)


func _physics_process(delta: float) -> void:
	#ajustar posicion si esta dragueado
	if(GameManager.isCokeDragging):
		
		#para que no salga de la pantalla
		var posX = clamp(get_global_mouse_position().x,0,get_viewport().size.x)
		var posY = clamp(get_global_mouse_position().y,0,get_viewport().size.y)
		global_transform.origin = Vector2(posX,posY)

func _input(event):
	
	#si soltamos la lata
	if event is InputEventMouseButton:
		if !event.is_pressed():
			releaseCan()
	pass

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			GameManager.isCokeDragging = true
			pass


func _on_body_entered(body: Node) -> void:
	canSound.play()
	pass # Replace with function body.
