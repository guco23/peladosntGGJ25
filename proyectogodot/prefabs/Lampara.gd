extends StaticBody2D

var pinned = true

func Fall():
	if pinned:
		pinned = false
		get_child(0).queue_free()
