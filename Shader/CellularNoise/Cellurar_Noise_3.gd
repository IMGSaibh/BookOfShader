extends Sprite2D
var mouse_position: Vector2 = Vector2(0.0, 0.0);


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseMotion:
		mouse_position = event.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	material.set_shader_parameter("mouse_xy", mouse_position)
