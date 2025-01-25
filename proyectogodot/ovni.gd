class_name ovni
extends Sprite2D


@export var target:Node2D
@export var initialPos:Vector2


@export var nRandomPositions:int
var randomPositionsCount:int = 0 

@export var velocityModule:float

enum STATES{RANDOM_POSITIONS,BUSCAR_ATAQUE, SALIR}

var curr_state:STATES 


var sprite_size:Vector2

var targetPos:Vector2

@export var closeUmbral:float = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	position = initialPos
	
	var texture_size = texture.get_size() 
	sprite_size = texture_size * scale  		

	curr_state = STATES.RANDOM_POSITIONS
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if curr_state == STATES.RANDOM_POSITIONS:
		if ((targetPos - position).length()) < closeUmbral:
			randomPositionsCount +=1
			if randomPositionsCount >= nRandomPositions:
				curr_state = STATES.BUSCAR_ATAQUE
			else:
				goRandomPosition()
		
		
		
	elif curr_state == STATES.BUSCAR_ATAQUE:
		pass
	
	
	
	elif curr_state == STATES.SALIR:
		pass
	
	
	
	pass
	
	
	
	
	
func validPos(pos:Vector2) -> bool:

	if pos.x > sprite_size.x and pos.x < (get_viewport_rect().size.x - sprite_size.x):
		if  pos.y > sprite_size.y and pos.y < (get_viewport_rect().size.y - sprite_size.y):
			return true
	return false


func goRandomPosition():
	var nextTarget = randf_range(get_viewport_rect().size.x,get_viewport_rect().size.y)
	
	while !validPos(nextTarget):
		nextTarget = randf_range(get_viewport_rect().size.x,get_viewport_rect().size.y)
	
	
	var dir:Vector2 = (nextTarget - position).lenght()
	
	velocity = dir * velocityModule
	
	
func atack():
	
	#moverse de izquierda a derecha y de derecha a izquierda
	
	#ir hacia el player rapido
	
	#disparar el laser
	
	pass
	
	
