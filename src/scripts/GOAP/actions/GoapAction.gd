class_name GoapAction

var owner
var preconditions
var effects
var target
var is_indirect

func _init(o):
	owner = o

func setup() -> bool:
	return true

func perform() -> bool:
	return false
