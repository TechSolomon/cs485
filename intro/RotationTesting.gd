extends Spatial

var t = 0 # Time since boot in seconds
export var angriness = 1 # Amount of change

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	var change = angriness*sin(2*t)
	
	var rot=Vector3(0,0,0) # XYZ rotation amount
	var speed=0.01 # radians/frame rotation speed
	if Input.is_physical_key_pressed(KEY_W):
		rot.x=+speed
	if Input.is_physical_key_pressed(KEY_S):
		rot.x=-speed
	if Input.is_physical_key_pressed(KEY_E):
		rot.z=+speed
	if Input.is_physical_key_pressed(KEY_Q):
		rot.z=-speed
	if Input.is_physical_key_pressed(KEY_A):
		rot.y=+speed
	if Input.is_physical_key_pressed(KEY_D):
		rot.y=-speed
		
	# transform.basis.x += rot.z*transform.basis.y;
	# transform.basis.y -= rot.z*transform.basis.x;
	# transform.basis.y += rot.x*transform.basis.z;
	# transform.basis.z -= rot.x*transform.basis.y;
	# transform.basis.z += rot.y*transform.basis.x;
	# transform.basis.x -= rot.y*transform.basis.z;
	# transform.basis=transform.basis.orthonormalized()
	
	print (transform.basis.get_rotation_quat())
	var cur : Quat=transform.basis.get_rotation_quat()
	var qrot = Quat(rot)*0.1
	# cur = qrot*cur
	cur = cur*qrot
	transform.basis=Basis(cur)
	
	# Write down coordinates
	# transform.basis=Basis.IDENTITY
	# transform.basis.x.y=change
	# transform.basis.y.x=-change
	# transform.basis=transform.basis.orthonormalized()
	
	# Use trig to compute cooridnates
	# var angle = change
	# var c = cos(angle)
	# var s = sin(angle)
	# transform.basis.x=Vector3(c,s,0)
	# transform.basis.y=Vector3(-s,c,0)
	
	pass
