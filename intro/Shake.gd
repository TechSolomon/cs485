extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var t = 0
export var angriness = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	transform.origin.x=angriness*sin(2*t)
	pass
