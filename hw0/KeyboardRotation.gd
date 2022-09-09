extends Spatial

export var angle = 0 # current orientation (degrees)
export var speed = 60 # degrees/sec motion rate
export var axis = Vector3(1,0,0) # rotation axis
export var keyUp = KEY_W # keyboard scancode for -
export var keyDown = KEY_S # keyboard scancode for -

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir = +0.0
	
	if Input.is_physical_key_pressed(keyUp):
		dir = +1.0
	if Input.is_physical_key_pressed(keyDown):
		dir = -1.0
	
	if dir!=0:
		angle += speed * delta * dir
		rotation_degrees = axis*angle
	pass
