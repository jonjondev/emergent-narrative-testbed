extends SmartObject

var interaction_points: Array = [
	Vector3(1.0, 0, 0),
	Vector3(-1.0, 0, 0),
	Vector3(1.0, 0, 1.0),
	Vector3(-1.0, 0, 1.0),
	Vector3(1.0, 0, -1.0),
	Vector3(-1.0, 0, -1.0),
]

func _init().():
	action_name = "*talking*"
	action_length = 3.0

func _ready():
	self_value = get_parent()

func interact(partner) -> Dictionary:
	if partner.navigation.distance_to(self_value.navigation.get_final_destination()) < .5:
		partner.navigation.navigate_to(self_value.translation + interaction_points[randi() % 6])
	return .interact(partner)

func tick_interaction(partner) -> void:
	partner.navigation.face_target(self_value.translation)
	.tick_interaction(partner)

func end_interaction() -> void:
	owner.blackboard["advertising_state"] = false
