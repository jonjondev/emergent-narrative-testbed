class_name GoapAction

var owner
var preconditions
var effects
var target
var is_indirect

func _init(o):
	owner = o

func perform() -> bool:
	return false

func setup() -> void:
	pass
