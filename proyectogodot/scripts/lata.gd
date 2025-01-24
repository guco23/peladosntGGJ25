extends RigidBody2D

var isPicked : bool
var isMoused : bool
var is_draggin: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	isPicked = false
	isMoused = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _input(event):
	if event is InputEventMouseButton:
		if !event.is_pressed():
			is_draggin = false
	pass

func _physics_process(delta: float) -> void:
	if(is_draggin):
		global_transform.origin = get_global_mouse_position()

func _on_body_entered(body: Node) -> void:
	print_debug("lata collision")


func _on_mouse_entered() -> void:
	isMoused = true
	print_debug("mouse entered")


func _on_mouse_exited() -> void:
	print_debug("mouse exited")
	isMoused = false


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			is_draggin = true
	pass # Replace with function body.
