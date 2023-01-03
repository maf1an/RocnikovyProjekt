extends Spatial
func _ready():
	pass
		
		
func _process(delta):
	if premenne.b == true:
		queue_free()
		premenne.ZaciatokHry()
		get_tree().change_scene("res://scenes/world/Menu.tscn")
