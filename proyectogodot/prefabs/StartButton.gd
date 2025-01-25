extends Area2D


var mainScene:Node2D
@export var cokeRef:Node2D
var canStart = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if(canStart and event.pressed):
			print_debug("Empieza")
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	canStart = true
	
	pass # Replace with function body.
