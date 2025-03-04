class_name ovni
extends RigidBody2D


@onready var sprite_2d: Sprite2D = $Sprite2D


@export var target:Node2D
@export var initialPos:Vector2


@export var nRandomPositions:int
var randomPositionsCount:int = 0 

@export var velocityModule:float

@export var timeToShoot:float
@export var timeToScape:float
@export var timeToCollider:float

var timeCounter:float

var canShot:bool = false
var canScape:bool = false

const BULLET = preload("res://prefabs/bullet.tscn")
const LASER = preload("res://prefabs/laser.tscn")

enum STATES{RANDOM_POSITIONS,COLOCARSE_ARRIBA,BUSCAR_ATAQUE,ATACAR, SALIR}

var curr_state:STATES 


var sprite_size:Vector2

var targetPos:Vector2

@export var closeUmbral:float = 10


@export var bulletSpeed:float = 800

@export var bulletSpawnOffset:Vector2 = Vector2(0,10)

var laser:Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	position = initialPos
	
	var texture_size = sprite_2d.texture.get_size() 
	sprite_size = texture_size * scale  		

	curr_state = STATES.RANDOM_POSITIONS
	
	goRandomPosition()
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	if curr_state == STATES.RANDOM_POSITIONS:
		if ((targetPos - position).length()) < closeUmbral:
			randomPositionsCount +=1
			if randomPositionsCount == nRandomPositions:
				curr_state = STATES.COLOCARSE_ARRIBA
				
				var nextTarget:Vector2 = \
				Vector2(
				randf_range(sprite_size.x,get_viewport_rect().size.x - sprite_size.x),
				sprite_size.y)
				
				targetPos = nextTarget
				
				setVelocityToDir()
			else:
				goRandomPosition()
		
	
	elif curr_state == STATES.COLOCARSE_ARRIBA:
		
		if ((targetPos - position).length()) < closeUmbral:
			curr_state = STATES.BUSCAR_ATAQUE
			
		pass
		
		
	elif curr_state == STATES.BUSCAR_ATAQUE:
		
		if abs(position.x -target.position.x)  < closeUmbral:
			
			curr_state = STATES.ATACAR
			
			linear_velocity = Vector2(0,0)
			
		else:
			if(target.position.x > position.x):
				linear_velocity = Vector2(1,0) * velocityModule
			else:
				linear_velocity = Vector2(-1,0) * velocityModule
		pass
	
	
	elif  curr_state == STATES.ATACAR:
		
		#esperar
		if !canShot:
			timeCounter += delta
			if timeCounter > timeToShoot:
				timeCounter = 0
				canShot = true
				#disparar bala/laser
				shoot()
				
		elif !canScape: #esperar a escapa
			timeCounter += delta
			
			if timeCounter > timeToCollider:
				
				#activar la layer 3 del laser
				
				if laser is CollisionObject2D:
					laser.set_collision_layer_value(3,true)
			
			if  timeCounter > timeToScape:
				canScape = true
				
				linear_velocity = Vector2(1,0) * velocityModule
				
				curr_state == STATES.SALIR
				
				if laser != null:
					laser.queue_free()
		pass
	
	
	elif curr_state == STATES.SALIR:
		
		if position.x > get_viewport_rect().size.x + sprite_size.x:
			queue_free()
		pass
	pass
	
	

#dispara aleatoriamente una bala o un laser hacia abajo
func shoot():
	
	var shootType = randi()%2
	
	print_debug("aaaa")
	
	#disparo normal
	if shootType == 0:
		
		
		print_debug("bbbb")
		
		var newBullet = BULLET.instantiate()
		
		newBullet.linear_velocity = Vector2(0,bulletSpeed)
		newBullet.position = Vector2(0,0) - bulletSpawnOffset
		
		print_debug("my pos:", position)
		print_debug("my global:",global_position)
		
		
		add_child(newBullet)
		
		
	elif shootType == 1:#disparo de laser
		
		laser = LASER.instantiate()
	
		#newBullet.position = global_position
		
		laser.get_child(1).play()	
		#add_sibling(newBullet)
		add_child(laser)
		
	
	get_node("Disparo").play()
	pass
	

	
	
func validPos(pos:Vector2) -> bool:

	if pos.x > sprite_size.x and pos.x < (get_viewport_rect().size.x - sprite_size.x):
		if  pos.y > sprite_size.y and pos.y < (get_viewport_rect().size.y - sprite_size.y):
			return true
	return false


func setVelocityToDir():
	
	var dir:Vector2 = (targetPos - position).normalized()
	linear_velocity = dir * velocityModule
	
func goRandomPosition(): 
	
	var nextTarget:Vector2 = \
	Vector2(
		randf_range(sprite_size.x,get_viewport_rect().size.x - sprite_size.x),
		randf_range(sprite_size.y,get_viewport_rect().size.y - sprite_size.y
		))
	
	targetPos = nextTarget
	
	setVelocityToDir()


func _on_audio_stream_player_2d_finished() -> void:
	get_node("AudioStreamPlayer2D").play()
	pass # Replace with function body.
