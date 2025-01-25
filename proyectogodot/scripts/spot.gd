extends Area2D

var anim:AnimatedSprite2D
var value:float = 5
var press:bool=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim = get_node("Sprite2D")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			press=true
		else:
			press=false
	

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseMotion and !GameManager.isCokeDragging and press:
		var ev := event as InputEventMouseMotion
		value-=abs(ev.velocity.length())*0.00005
		anim.frame = floor(value)-1
		if (value <= 0):
			queue_free()
	pass # Replace with function body.
