extends KinematicBody

export(NodePath) var animationtree
export(NodePath) onready var camera = get_node(camera)

onready var _anime_tree = get_node(animationtree)

var gravity = Vector3.ZERO
var _last_pos
var _pressed : bool = false

func _physics_process(delta):
	var root_motion : Transform = _anime_tree.get_root_motion_transform()
	var v = root_motion.origin / delta
	if is_on_floor():
		gravity = Vector3.ZERO
	else:
		gravity += Vector3(0.0,-0.983,0.0) * delta
	v+=gravity
#	if Input.is_action_pressed("ui_select"):
#		_anime_tree["parameters/playback"].travel("Running")
#	else:
#		_anime_tree["parameters/playback"].travel("Idle")
	var dir : Vector3 = Vector3.ZERO
	if Input.is_action_pressed("forward"):
		dir.z += 0.1
	if Input.is_action_pressed("backward"):
		dir.z -= 0.1
	if Input.is_action_pressed("left"):
		dir.x += 0.1
	if Input.is_action_pressed("right"):
		dir.x -= 0.1
		
	if dir.length_squared() > 0.01:
		dir = dir.rotated(Vector3.UP, camera.setup.rotation.y)
		
		var player_heading_2d := Vector2(self.transform.basis.z.x, self.transform.basis.z.z)
		var desired_heading_2d := Vector2(dir.x, dir.z)
		
		var phi : float = desired_heading_2d.angle_to(player_heading_2d)
		phi = phi * delta * 3.0
		self.rotation.y += phi
		v = v.rotated(Vector3.UP, self.rotation.y)
		
		if Input.is_action_pressed("sprint"):
			_anime_tree["parameters/playback"].travel("Running")
		else:
			_anime_tree["parameters/playback"].travel("Walking")
	else:
		_anime_tree["parameters/playback"].travel("Idle")
		v = v.rotated(Vector3.UP, self.rotation.y)
	_anime_tree["parameters/conditions/jump"] = Input.is_action_pressed("jump")
	move_and_slide(v,Vector3.UP)
