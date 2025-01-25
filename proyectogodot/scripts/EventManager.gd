extends Node

@export var minTime : float #El tiempo minimo para nuevo vento
@export var startTime : float #El tiempo inicial de nuevo evento
@export var reductonFactor : float #El factor de reduccion del tiempo por evento

@export var moscaWeight : int
@export var discoWeight : int
@export var manoWeight : int
@export var frisbeeWeight : int
@export var luzWeight : int

@export var moscaPref : Node2D #El prefab de la mosca
@export var discoPref : Node2D #El prefab del disco (solo puede haber un disco)
@export var mano : Node2D #La mano en la escena
@export var fisbeeSpawner : Node2D
@export var luz : Node2D

var rand = RandomNumberGenerator.new()
var totalWieight : int

#Se encarga de accionar los distintos eventos, teniendo en cuenta cuánto tiempo lleva el jugador en partida
#Cada evento se efectúa de formas distintas y tiene distintas condiciones

#La mano sólo hay una y hay que llamar a su metodo launch punch
#La mosca hay que instanciarla entera
#Los frisbys se generan llamando a su spawner
#El disco se spawnea una vez y se queda ahí para siempre rebotando
#El interruptor tbd

func _ready() -> void:
	get_child(0).wait_time = startTime
	discoWeight += moscaWeight
	manoWeight += discoWeight
	frisbeeWeight += manoWeight
	luzWeight += frisbeeWeight
	totalWieight = luzWeight
	print_debug(str(moscaWeight) + " " + str(discoWeight) + " " + str(manoWeight) + " " + str(frisbeeWeight) + " " + str(luzWeight))
	get_child(0).start(startTime)
	pass

func _process(delta: float) -> void:
	pass

func TimeEvent():
	# print_debug(get_child(0).wait_time)
	if(startTime > minTime):
		startTime -= reductonFactor
	get_child(0).start(startTime) 
	LaunchEvent()

func LaunchEvent():
	pass
	#Selecciona aleatoriamente un evento de la lista de eventos
