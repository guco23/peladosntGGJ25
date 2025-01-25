extends RigidBody2D

var isPicked : bool
var isMoused : bool
var is_draggin: bool
var gasVal: float


signal gasUp (gasValue)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	isPicked = false
	isMoused = false
	contact_monitor = true
	max_contacts_reported = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func releaseCan():
	is_draggin = false
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.3


func _input(event):
	if event is InputEventMouseButton:
		if !event.is_pressed():
			releaseCan()
	if event is InputEventMouseMotion and is_draggin:
		if event.velocity.length()/200 > 4:
			gasVal+= event.velocity.length()/200
			gasUp.emit(gasVal)
	pass

func _physics_process(delta: float) -> void:
	if(is_draggin):
		global_transform.origin = get_global_mouse_position()
	if(abs(angular_velocity) > 0.4 || (!is_draggin && linear_velocity.length() > 5)):
		#print_debug("angular velocity:", angular_velocity," lineal velocity: ",linear_velocity)
		gasVal+= abs(angular_velocity)+linear_velocity.length()*0.001
		gasUp.emit(gasVal)

func _on_body_entered(body: Node) -> void:
	if body is PhysicsBody2D and !body.get_collision_layer_value(2):
		releaseCan()
		#var time = get_tree().create_timer(0.2)
		#time.timeout.connect(body.queue_free)
	#print_debug("lata collision")


func _on_mouse_entered() -> void:
	isMoused = true
	#print_debug("mouse entered")


func _on_mouse_exited() -> void:
	#print_debug("mouse exited")
	isMoused = false


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			is_draggin = true
			pass
	pass # Replace with function body.
