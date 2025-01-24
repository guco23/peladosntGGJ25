extends RigidBody2D

var isPicked : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	isPicked = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isPicked:
		position = get_viewport().get_mouse_position()


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		isPicked = true;
	
		

func _on_body_entered(body: Node) -> void:
	print_debug("lata collision")
