extends Area
func _on_apple_body_entered(body):
	if body.get_name() == "Player":
		premenne.Add()
		print(premenne.a)
		queue_free()
		
