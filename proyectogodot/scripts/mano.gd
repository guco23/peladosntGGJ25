extends StaticBody2D

@export var canRef: Node2D
@export var anticipationTime:float =3
var anim:AnimatedSprite2D
var originalPos:Vector2;

var isActive : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	originalPos = position
	anim = get_node("Sprite2D")

func launchPunch()->void:
	if !isActive:
		var tw = get_tree().create_tween()
		tw.tween_property(self,"position",canRef.position+Vector2(100,0),anticipationTime)
		tw.tween_callback(punch)
		isActive = true

func punch():
	var twee = get_tree().create_tween()
	twee.tween_property(self,"position",canRef.position+Vector2(-100,-60),0.2)
	twee.tween_callback(reset_punch)
	twee.tween_property(self,"position",originalPos,anticipationTime-2)
	twee.tween_callback(Returned)
	anim.frame = 1

func reset_punch()->void:
	anim.frame = 0


func Returned():
	isActive = false
