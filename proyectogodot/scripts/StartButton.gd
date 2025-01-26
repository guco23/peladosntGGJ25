extends Area2D

var anim:AnimatedSprite2D
var mainScene:Node2D
@export var cokeRef:Node2D
var canStart = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim = get_node($Sprite2D.get_path())
	if GameManager.game_time > 0:
		canStart = true

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if(canStart and event.pressed):
			anim.play()
			get_node("AudioStreamPlayer").play()

func _on_body_exited(body: Node2D) -> void:
	canStart = true

func _on_sprite_2d_animation_finished() -> void:
	#Cambiar de escena
	GameManager.startGame()
