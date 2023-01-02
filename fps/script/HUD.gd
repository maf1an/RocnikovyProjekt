extends Control
var premenna_jablk: int = 0
var nic = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect/Label.text = str(premenna_jablk)
#	_on_apple_pocet(premenna_jablk)
#	print(premenna_jablk)
#	get_node("ColorRect/Label").text = str(premenna_jablk)
#	print(premenne.a)
func _on_apple_pocet(value):
	premenna_jablk += value
	$ColorRect/Label.text = str(premenna_jablk)
