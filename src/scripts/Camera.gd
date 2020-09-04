extends Camera

export (NodePath) var player

func _ready():
	player = get_node(player)

func _physics_process(delta):
	var cam_translation = translation
	cam_translation.y = 0
	var cam_y = translation.y
	var player_translation = player.translation
	player_translation.y = 0
	player_translation.z += 3
	if (cam_translation - player_translation).length() > 0.1:
		translation = lerp(cam_translation, player_translation, delta)
		translation.y = cam_y
