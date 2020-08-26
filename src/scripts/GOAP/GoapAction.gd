class_name GoapAction

var owner
var preconditions
var effects
var target

func _init(o):
	owner = o

func perform() -> bool:
	return false
