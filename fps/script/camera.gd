extends Camera


export(NodePath) onready var target = get_node(target)
export(Resource) var setup
var _pressed := false
var _last_pos
var vairaible = false
var radius = 5
onready var player=get_parent().get_node("Player")
var angle = 0
var rotate_around_player = false

func _ready():
	if setup.target_offset == Vector3.ZERO:
		setup.target_offset = self.transform.origin - target.transform.origin - setup.anchor_offset
	if setup.look_target == Vector3.ZERO:
		setup.look_target = Vector3(0,0, 100.0)
	setup.pitch_limit.x = deg2rad(setup.pitch_limit.x)
	setup.pitch_limit.y = deg2rad(setup.pitch_limit.y)

func _process(delta):
	if rotate_around_player:
		var x = player.transform.origin.x + radius * cos(angle)
		var z = player.transform.origin.z + radius *sin(angle)
		var camera_pos = Vector3(x,player.transform.origin.y + 2, z)
		look_at(player.transform.origin, Vector3(0,1,0))
		transform.origin = camera_pos
		angle += 0.05 * delta
		if angle >= 2 * PI:
			angle -= 2 * PI
		elif angle < 0:
			angle += 2*PI
		player.controller_enabled = false
	else:
		player.controller_enabled = true
		self.transform.origin = target.transform.origin + setup.anchor_offset
		var target_offset = setup.target_offset
		var look_at = setup.look_target
		var up_down_axis = Vector3.RIGHT.rotated(Vector3.UP, setup.rotation.y)
		target_offset = target_offset.rotated(Vector3.UP, setup.rotation.y)
		look_at = look_at.rotated(Vector3.UP, setup.rotation.y)
		target_offset = target_offset.rotated(up_down_axis, setup.rotation.x)
		look_at = look_at.rotated(up_down_axis, setup.rotation.x)

		self.transform.origin += target_offset
		self.look_at(look_at, Vector3.UP)
		collide()

func _on_Area_body_entered(body):
	rotate_around_player = true

func _on_Area_body_exited(body):
	rotate_around_player = false

func _unhandled_input(event):
	if event is InputEventScreenTouch and event.pressed == true:
		if _pressed == false:
			_pressed = true
			_last_pos = event.position
	if event is InputEventScreenTouch and event.pressed == false:
		_pressed = false
	if event is InputEventScreenDrag and _pressed == true:
		var diff : Vector2 = _last_pos - event.position
		diff = diff / 100.0
		setup.rotation.y += diff.x
		setup.rotation.x -= diff.y
		setup.rotation.x = clamp(setup.rotation.x, setup.pitch_limit.x, setup.pitch_limit.y)
		_last_pos = event.position

func collide():
	var start = target.transform.origin + setup.anchor_offset
	var end = self.transform
	var space_state = get_world().direct_space_state
	var col = space_state.intersect_ray(start, end)
	if not col.empty():
		self.transform.origin = col.position
