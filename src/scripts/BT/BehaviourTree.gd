class_name BehaviourTree
extends Primitive

var root

func _init(o).(o):
	pass

func update() -> int:
	return root.tick()

func on_terminate(status) -> void:
	root.on_terminate(status)
	.on_terminate(status)
