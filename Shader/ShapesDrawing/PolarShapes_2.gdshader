shader_type canvas_item;
#define TWO_PI 6.28318530718
uniform float pos_x : hint_range(0.0, 1.0);
uniform float pos_y : hint_range(0.0, 1.0);
uniform int corner_count : hint_range(0.0, 10.0);


float draw_shape(vec2 _uv, vec2 pos, int corners_count)
{
	float d = 0.0;
			
	vec3 color = vec3(0.0);
	vec2 uv = _uv;

	// Remap the space to -1. to 1.
	uv = uv * 2.0 - 1.0;

	// Number of sides of your shape

	// Angle and radius from the current pixel
	float a = atan(uv.x, uv.y) + PI;
	float r = TWO_PI/float(corners_count);

	// Shaping function that modulate the distance
	d = cos(floor(0.5 + a/r) * r - a) * length(uv);


	// color = vec3(d);
	return d;
}

void fragment() {

	vec3 color = vec3(1.0 - smoothstep(0.4, 0.41, draw_shape(UV, vec2(pos_x, pos_y), corner_count)));
	COLOR = vec4(color,1.0);
}

