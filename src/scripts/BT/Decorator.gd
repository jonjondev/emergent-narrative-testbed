class_name Decorator
extends Behaviour

var child: Behaviour

func _init(behaviour: Behaviour):
	child = behaviour

func on_terminate(status):
	child.on_terminate(status)
	.on_terminate(status)
