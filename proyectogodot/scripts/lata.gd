extends RigidBody2D

var isPicked : bool
var isMoused : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	isPicked = false
	isMoused = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isPicked:
		position = get_viewport().get_mouse_position()


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if isMoused:
			Pick()
	if event is InputEventMouseButton and event.is_released():
		Drop()


func Drop():
	isPicked = false

func Pick():
	isPicked = true

func _on_body_entered(body: Node) -> void:
	print_debug("lata collision")


func _on_mouse_entered() -> void:
	isMoused = true
	print_debug("mouse entered")


func _on_mouse_exited() -> void:
	print_debug("mouse exited")
	isMoused = false
