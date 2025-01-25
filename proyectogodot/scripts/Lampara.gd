extends RigidBody2D

var pinned = true

func Fall():
	if pinned:
		freeze = false
