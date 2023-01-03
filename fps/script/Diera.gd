extends Area

func _on_Area_body_entered(body):
	if body.get_name() == "Player":
		premenne.koniecHry()
		print("Spadol si")
