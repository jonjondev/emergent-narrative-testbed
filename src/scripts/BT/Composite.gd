class_name Composite
extends Behaviour

var children: Array

func _init(behaviours: Array):
	children = behaviours

func on_terminate(status):
	for child in children:
		child.on_terminate(status)
	.on_terminate(status)
