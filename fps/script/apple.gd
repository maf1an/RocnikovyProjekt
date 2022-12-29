extends Area

onready var jablko = 0
func _on_apple_body_entered(body):
	if body.get_name() == "Player":
		jablko += 1
		print(jablko)
		queue_free()
		
