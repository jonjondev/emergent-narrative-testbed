class_name SmartObject
extends Node

var action_name = "*<empty>*"
var action_length = 1.0
var self_value = self

func interact(_partner) -> Dictionary:
	return {
		"name": action_name,
		"length": action_length,
	}

func end_interaction() -> void:
	pass
