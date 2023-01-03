extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	if premenne.b == true:
#		queue_free()
#		get_tree().change_scene("res://scenes/world/Menu.tscn")
		get_tree(). reload_current_scene()
func _on_Button_pressed():
	get_tree().change_scene("res://scenes/world/World.tscn")
func _on_Button3_pressed():
	get_tree().quit()
