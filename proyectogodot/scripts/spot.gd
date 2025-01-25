extends Area2D

var value:float = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseMotion and !GameManager.isCokeDragging:
		var ev := event as InputEventMouseMotion
		value-=abs(ev.velocity.length())*0.001
		if (value <= 0):
			queue_free()
	pass # Replace with function body.
