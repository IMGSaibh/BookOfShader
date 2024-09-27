extends Sprite2D

var mouse_position: Vector2 = Vector2(0.0, 0.0);
var points = []
var point_texture : ImageTexture

# Called when the node enters the scene tree for the first time.
func _ready():
	point_texture = ImageTexture.new()
	update_texture()

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			add_point(Vector2(event.position))
			print(points)
	elif event is InputEventMouseMotion:
		mouse_position = event.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	material.set_shader_parameter("mouse_xy", mouse_position)

func add_point(point: Vector2):
	if points.size() > 5:
		points.clear()
	var normalized_point: Vector2 = Vector2.ZERO
	normalized_point.x = point.x / get_viewport().get_visible_rect().size.x
	normalized_point.y = point.y / get_viewport().get_visible_rect().size.y
	points.append(normalized_point)
	update_texture()

func update_texture():
	var image = Image.new()
	image = Image.create(256, 256, false, Image.FORMAT_RGBAF)
	if image.is_empty():
		return
		
	for i in range(points.size()):
		var p = points[i]
		image.set_pixel(i, 0, Color(p.x, p.y, 0, 1))  # Speichere die Punkte in der Textur

	point_texture = ImageTexture.create_from_image(image)
	# Aktualisiere die Textur im Shader
	material.set_shader_parameter("point_texture", point_texture)
	material.set_shader_parameter("numPoints", points.size())
