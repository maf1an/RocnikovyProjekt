extends Area
func _on_apple_body_entered(body):
	if body.get_name() == "Player":
		queue_free()
