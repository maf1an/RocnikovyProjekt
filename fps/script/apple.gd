extends Area
#onready var jablko = 0
signal pocet(value)

func _on_apple_body_entered(body):
	if body.get_name() == "Player":
		#premenne.add_score()
		emit_signal("pocet", 1)
		queue_free()
