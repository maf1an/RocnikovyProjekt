extends Area
func _on_apple_body_entered(body):
	if body.get_name() == "Player":
		
		#get_node("/root/premenne").Add()
		queue_free()
		
