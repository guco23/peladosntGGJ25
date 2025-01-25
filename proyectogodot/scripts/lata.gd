extends RigidBody2D

var isPicked : bool
var isMoused : bool
var gasVal: float

enum GasMode {VELOCITY, ACELERATION }

@export var mode:GasMode 

var lastLinearVelocity:Vector2 = Vector2(0,0)
var lastAngularVelocity:float = 0
var lastPos:Vector2 
var lastDragginTime:float


signal gasUp (gasValue)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#inicializar variables
	isPicked = false
	isMoused = false
	contact_monitor = true
	max_contacts_reported = 1
	
	lastPos = position
	lastDragginTime = Time.get_ticks_msec()


#soltar la lata
func releaseCan():
	
	GameManager.isCokeDragging = false
	#ajustar velocidades 
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.3


#calculo del gas si estas dragueando la lata, solo para modo VELOCITY
func onLataDragging(event,delta:float):
	if mode == GasMode.VELOCITY:
		#calculo del gas
		if event.velocity.length()/200 > 4:
			gasVal+= event.velocity.length()/200
			gasUp.emit(gasVal)
	elif  mode == GasMode.ACELERATION:
		var vel:Vector2 = abs(position- lastPos)/delta
		var aceleration = abs((lastLinearVelocity - vel)).length()/delta
		
		print_debug("acel:",aceleration)
		
		gasVal += aceleration
		
		lastPos = position
		lastLinearVelocity = vel
		
		

#calculo del gas si no estas draguenado la lata 
func onLataMoving(delta:float):
	if mode == GasMode.VELOCITY:
		if(abs(angular_velocity) > 0.4 || (!GameManager.isCokeDragging && linear_velocity.length() > 5)):
			#print_debug("angular velocity:", angular_velocity," lineal velocity: ",linear_velocity)
			gasVal+= abs(angular_velocity)+linear_velocity.length()*0.001
	elif mode == GasMode.ACELERATION and !GameManager.isCokeDragging:
		#modulo de la aceleracion
		var acelerationLinear = (lastLinearVelocity - linear_velocity).length()
		var acelerationAngular = lastAngularVelocity - angular_velocity
		
		print_debug("no deberia estar aqu")
		gasVal += (abs(acelerationLinear) + abs(acelerationAngular)) * 0.001
		
		lastLinearVelocity = linear_velocity
		lastAngularVelocity = angular_velocity
		
	
	#en cualquier caso:
	gasUp.emit(gasVal)
	


func _input(event):
	
	#si soltamos la lata
	if event is InputEventMouseButton:
		if !event.is_pressed():
			releaseCan()
	#si estamos moviendo la lata
	if event is InputEventMouseMotion and GameManager.isCokeDragging:
		var currTime = Time.get_ticks_msec()
		
		
		onLataDragging(event,currTime-lastDragginTime)
		lastDragginTime = currTime
		
		
	pass

func _physics_process(delta: float) -> void:
	
	#ajustar posicion si esta dragueado
	if(GameManager.isCokeDragging):
		
		#para que no salga de la pantalla
		var posX = clamp(get_global_mouse_position().x,0,get_viewport().size.x)
		var posY = clamp(get_global_mouse_position().y,0,get_viewport().size.y)
			
		global_transform.origin = Vector2(posX,posY)
		
	onLataMoving(delta)

func _on_body_entered(body: Node) -> void:
	
	#si colisiono con un objeto de los que molestan
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


#evento que succede dentro del collider
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			GameManager.isCokeDragging = true
			pass
