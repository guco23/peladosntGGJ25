extends RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameManager.high_score > 0:
		text = "High score: " + str(GameManager.high_score)
		visible = true
