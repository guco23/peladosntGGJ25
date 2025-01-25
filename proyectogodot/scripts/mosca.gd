extends StaticBody2D

@export var audio:AudioStreamPlayer2D
@export var playerRef:Node2D
@export var moscaSpeed:float = 5
@export var variablity:float = 2
@export var offset:Vector2 = Vector2(0,50)
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Sprite2D").play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var val=rng.randf_range(-variablity,variablity)
	position += ((playerRef.position+offset-position).normalized()*moscaSpeed+Vector2(0,variablity))*delta
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		get_node("SquashBug").play()
		queue_free()


func _on_audio_stream_player_2d_finished() -> void:
	audio.play()
	pass # Replace with function body.
