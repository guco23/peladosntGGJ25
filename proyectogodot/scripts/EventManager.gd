extends Node

@export var minTime : float #El tiempo minimo para nuevo vento
@export var startTime : float #El tiempo inicial de nuevo evento
@export var reductonFactor : float #El factor de reduccion del tiempo por evento

@export var moscaWeight : int
@export var discoWeight : int
@export var manoWeight : int
@export var frisbeeWeight : int
@export var luzWeight : int
@export var manchaWeight : int

@export var playerRef : Node2D

var moscaPref : PackedScene = preload("res://prefabs/Mosca.tscn") #El prefab de la mosca
var discoPref : PackedScene = preload("res://prefabs/disco.tscn") #El prefab del disco (solo puede haber un disco)
@export var mano : Node2D #La mano en la escena
@export var frisbeeSpawner : Node2D
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
	manchaWeight += luzWeight
	totalWieight = manchaWeight
	print_debug(str(moscaWeight) + " " + str(discoWeight) + " " + str(manoWeight) + " " + str(frisbeeWeight) + " " + str(luzWeight) + " " + str(manchaWeight))
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
	var val = rand.randi_range(0, totalWieight)
	print_debug(val)
	if val <= moscaWeight:
		GeneraMosca()
	elif val <= discoWeight:
		GeneraDisco()
		pass
	elif val <= manoWeight:
		LlamaMano()
		pass
	elif val <= frisbeeWeight:
		LlamaFrisbee()
		pass
	elif val <= luzWeight:
		ApagaLuz()
		pass
	elif val <= manchaWeight:
		Manchar()
		pass
	#Selecciona aleatoriamente un evento de la lista de eventos

func GeneraMosca():
	var mosca = moscaPref.instantiate()
	mosca.playerRef = playerRef
	add_sibling(mosca)

func GeneraDisco():
	discoWeight = moscaWeight #para que no pueda volver a suceder

func LlamaMano():
	mano.launchPunch()

func LlamaFrisbee():
	frisbeeSpawner.spawnFrisby()

func ApagaLuz():
	print_debug("apaga luz")

func Manchar():
	print_debug("mancha")
