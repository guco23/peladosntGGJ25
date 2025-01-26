extends StaticBody2D

@export var audio:AudioStreamPlayer2D
@export var playerRef:Node2D
@export var moscaSpeed:float = 5
@export var variablity:float = 2
@export var offset:Vector2 = Vector2(0,50)
var rng = RandomNumberGenerator.new()


@export var mainMenu:bool 

var targetPos:Vector2

var closeUmbral:float = 10



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Sprite2D").play()
	
	
	targetPos = Vector2(\
			randf_range(100,get_viewport_rect().size.x -100),
			randf_range(100,get_viewport_rect().size.y -100))
			
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if !mainMenu:
		var val=rng.randf_range(-variablity,variablity)
		position += ((playerRef.position+offset-position).normalized()*moscaSpeed+Vector2(0,variablity))*delta
		
		
		if(position.x < playerRef.position.x):
			get_child(0).flip_h = true
		else: 
			get_child(0).flip_h = false
	
	else:
		
		if ((targetPos-position).length()) < closeUmbral:
						
			targetPos = Vector2(\
			randf_range(100,get_viewport_rect().size.x -100),
			randf_range(100,get_viewport_rect().size.y -100))
			
		else:
			
			var dir = targetPos  -position
			
			position += dir.normalized()*moscaSpeed*delta
			print_debug(dir)
		
		
		if(position.x < targetPos.x):
			get_child(0).flip_h = true
		else: 
			get_child(0).flip_h = false
		
		
		pass
	
	
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		get_node("SquashBug").play()
		queue_free()


func _on_audio_stream_player_2d_finished() -> void:
	audio.play()
	pass # Replace with function body.
