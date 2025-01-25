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
@export var lamparaWeight : int
@export var ovniWeight : int

@export var playerRef : Node2D

var moscaPref : PackedScene = preload("res://prefabs/Mosca.tscn") #El prefab de la mosca
var discoPref : PackedScene = preload("res://prefabs/disco.tscn") #El prefab del disco (solo puede haber un disco)
var manchaPref : PackedScene = preload("res://prefabs/Spot.tscn") #El prefab de la mancha
var ovniPref : PackedScene = preload("res://prefabs/ovni.tscn")

@export var mano : Node2D #La mano en la escena
@export var frisbeeSpawner : Node2D
@export var interruptorYfondo : Node2D
@export var lampara : Node2D

var rand = RandomNumberGenerator.new()
var totalWeight : int

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
	lamparaWeight += manchaWeight
	ovniWeight += lamparaWeight
	totalWeight = ovniWeight
	get_child(0).start(startTime)

func TimeEvent():
	# print_debug(get_child(0).wait_time)
	if(startTime > minTime):
		startTime -= reductonFactor
	get_child(0).start(startTime) 
	LaunchEvent()

func LaunchEvent():
	var val = rand.randi_range(0, totalWeight)
	print_debug(val)
	if val <= moscaWeight:
		GeneraMosca()
	elif val <= discoWeight:
		GeneraDisco()
	elif val <= manoWeight:
		LlamaMano()
	elif val <= frisbeeWeight:
		LlamaFrisbee()
	elif val <= luzWeight:
		ApagaLuz()
	elif val <= manchaWeight:
		Manchar()
	elif val <= lamparaWeight:
		TiraLampara()
	elif val <= ovniWeight:
		GeneraOvni()
	#Selecciona aleatoriamente un evento de la lista de eventos

func GeneraMosca():
	var mosca = moscaPref.instantiate()
	mosca.playerRef = playerRef
	add_sibling(mosca)

func GeneraDisco():
	var disco = discoPref.instantiate()
	disco.position = get_viewport().size / 2
	add_sibling(disco)
	discoWeight = moscaWeight #para que no pueda volver a suceder

func GeneraOvni():
	var ovni = ovniPref.instantiate()
	ovni.target = playerRef
	add_sibling(ovni)

func LlamaMano():
	mano.launchPunch()

func LlamaFrisbee():
	frisbeeSpawner.spawnFrisby()

func ApagaLuz():
	interruptorYfondo.get_child(0).apagarLuz()
	get_node("switch").play()

func Manchar():
	var mancha = manchaPref.instantiate()
	var x = rand.randf_range(0, get_viewport().size.x)
	var y = rand.randf_range(0, get_viewport().size.y)
	mancha.position = Vector2(x,y)
	add_sibling(mancha)
	#tirar sonido pringue

func TiraLampara():
	
	if lampara != null:
		lampara.Fall()
