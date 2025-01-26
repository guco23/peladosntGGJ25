extends RigidBody2D

#variables drag && drop
var isPicked : bool
var isMoused : bool

#valor del gas
var gasVal: float

enum GasMode {VELOCITY, ACELERATION }

@export var mode:GasMode 

@export var releaseCanMinAngularVelocity:float = 0.3
@export var releaseCanMaxAngularVelocity:float = 1

@export var lataDragginLinealVelUmbral:float = 4
@export var lataMovingLinealVelUmbral:float = 5
@export var lataMovingAngularVelUmbral:float = 0.4



#variables para aceleracion
var lastLinearVelocity:Vector2 = Vector2(0,0)
var lastAngularVelocity:float = 0
var lastPos:Vector2 
var lastDragginTime:float

#variables para volar la lata

#es el angulo random en que salta hacia arriba, 180 todo el arco superior completo, 360 puede ir hacia abajo  
@export var angleUpApertura:float  

#fuerza con la que salta la lata al chocar
@export var velocityColisionModule:float

@export var minCollisonAngleVel:float
@export var maxCollisonAngleVel:float


#tiempo que tarda desde detectar la colision hasta chocars
@export var timeToFly:float
var timeToFlyCounter:float = 0

#tiempo que es invencible la lata despues de chocar
@export var postColisionInvencibleTime:float 

var invencibleTimeCounter:float

#tiempo que es invencible la lata nada mas cogerla, opcional
@export var justPickedInvencibleTime:float 

#si la lata es invencible en este instante
var invencible:bool 

var collisioned:bool = false

var linealVelocityToApply:Vector2 
var angularVelocityToApply:float

#Animacion de la lata
var anim:AnimatedSprite2D

#SonidoCosas
var audi:AudioStreamPlayer2D

var shaker : Node2D
@export var shakeIntensity : int
@export var gameOverSprite : Node2D

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
	audi = get_node("AudioStreamPlayer2D")
	anim = get_node("Sprite2D")
	shaker = get_node("ShakerComponent2D")

#soltar la lata
func releaseCan():
	
	GameManager.isCokeDragging = false
	#ajustar velocidades 
	linear_velocity = Vector2.ZERO
	
	var ang_vel = randf_range(releaseCanMinAngularVelocity,releaseCanMaxAngularVelocity)
	
	var postive:bool = true if randi()%2 == 0 else false
	
	if(!postive): ang_vel *= -1
	
	angular_velocity = ang_vel


#calculo del gas si estas dragueando la lata, solo para modo VELOCITY
func onLataDragging(event,delta:float):
	if mode == GasMode.VELOCITY:
		#calculo del gas
		if event.velocity.length()/200 > lataDragginLinealVelUmbral:
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
		if(abs(angular_velocity) > lataMovingAngularVelUmbral || (!GameManager.isCokeDragging && linear_velocity.length() > lataMovingLinealVelUmbral)):
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
	if body is PhysicsBody2D and body.get_collision_layer_value(3):
		releaseCan()
		#var time = get_tree().create_timer(0.2)
		#time.timeout.connect(body.queue_free)
	#print_debug("lata collision")
	
	var coll = body as CollisionObject2D
	if coll.get_collision_layer_value(2) or coll.get_collision_layer_value(7):
		get_node("WoodHit").play()
		pass


func _on_mouse_entered() -> void:
	#print_debug("mouse entered")
	isMoused = true


func _on_mouse_exited() -> void:
	#print_debug("mouse exited")
	isMoused = false


#evento que succede dentro del collider
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			GameManager.isCokeDragging = true
			pass


#Esto hay que parametrizarlo un poco para que quede elegante
func _on_gas_up(gasValue: Variant) -> void:
	if(gasValue < GameManager.gasThreshold-1200):
		#frame inicial
		anim.frame =0
	elif gasValue<GameManager.gasThreshold-1000:
		#frame 2
		anim.frame = 1
	elif gasValue<GameManager.gasThreshold-500:
		#frame 3
		anim.frame = 2
	elif gasValue > GameManager.gasThreshold:
		GameManager.lost()
		gameOverSprite.visible = true
	shaker.intensity = gasValue / GameManager.gasThreshold * shakeIntensity


func _process(delta: float) -> void:
	
	if collisioned:
		timeToFlyCounter += delta
		if timeToFlyCounter > timeToFly:
			
			linear_velocity += linealVelocityToApply
			angular_velocity += angularVelocityToApply
			
			collisioned = false
			invencible = true
			timeToFlyCounter = 0
			invencibleTimeCounter = 0

	if invencible:
		invencibleTimeCounter += delta
		if invencibleTimeCounter > postColisionInvencibleTime:
			invencible = false
			invencibleTimeCounter = 0

func isInLayer(layerBody:int, layerTarget:int) -> bool:
	
	#print_debug("estoy aqui", layerBody,layerTarget)
	
	if layerBody & (1 << (layerTarget-1)):
		return true
	else:
		return false

#cuando el trigger 2d detecta collision
func _on_trigger_enter(body: Node2D) -> void:
	if body is CollisionObject2D:
		if isInLayer(body.collision_layer,3):
			#mandar la lata a tomar por culo
			a_volar(body) 

func a_volar(body:Node2D):
	
	if collisioned: return
	if invencible: return
	
	print_debug("aqui")
	releaseCan()
	audi.play()
	var angle = randf_range(-angleUpApertura/2,angleUpApertura/2)
	
	var dirX = sin(deg_to_rad(angle))
	var dirY = cos(deg_to_rad(angle))
	var dir = Vector2(dirX,-dirY)
	
	var angleVel = randf_range(minCollisonAngleVel,maxCollisonAngleVel)
	
	linealVelocityToApply = dir * velocityColisionModule
	angularVelocityToApply = angleVel
	
	collisioned = true
	timeToFlyCounter = 0

	
	pass
