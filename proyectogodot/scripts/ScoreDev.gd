class_name gasCounter
extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_lata_gas_up(gasValue: Variant) -> void:
	self.text = str(gasValue)
	pass # Replace with function body.
