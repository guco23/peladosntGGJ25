class_name interruptor

extends Sprite2D


@export var fondo:fondo_negro 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if fondo.visible: 
				fondo.encenderLuz()
				get_node("AudioStreamPlayer2D").play()
			
			
	
	pass # Replace with function body.
