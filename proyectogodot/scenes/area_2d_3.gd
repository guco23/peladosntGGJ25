extends Node2D

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		get_tree().change_scene_to_file("res://scenes/CreditsScene.tscn")
