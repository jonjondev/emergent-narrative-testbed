extends SmartObject

func _init().():
	action_name = "*exiting*"
	action_length = 0.5

func interact(partner) -> Dictionary:
	partner.queue_free()
	return .interact(partner)
