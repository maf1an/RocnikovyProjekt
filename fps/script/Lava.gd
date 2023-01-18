extends Area

func _on_Lava_body_entered(body):
	if body.get_name() == "Player":
		premenne.koniecHry()
