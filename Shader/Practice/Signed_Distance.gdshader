shader_type canvas_item;
uniform float pos_x : hint_range(0.0, 1.0);
uniform float pos_y : hint_range(0.0, 1.0);
uniform float radius : hint_range(0.0, 0.5);
uniform float moveable_angle : hint_range(0.0, 180.0);

#define TWO_PI 6.28318530718

float archie_circle(vec2 uv)
{
	// P(x, y) auf dem Einheitskreis ist x = cos(angle_in_rad) und y = sin(angle_in_rad)
	vec2 pos = uv - vec2(pos_x, pos_y);
	float angle_in_rad = atan(pos.y, pos.x);
	float angle_in_degree = (angle_in_rad * 180.0/PI);
	float value = 0.0;
	if(angle_in_degree > moveable_angle)
	{
		value = 1.0;
	}
	if(angle_in_degree < - moveable_angle)
	{
		value = 1.0;
	}
	
	value -= sin(length(pos) * 19.0 * radius);

	value = step(0.1, value);
	
	return value;
}

void fragment() {
	vec3 color = vec3(0.0);
	vec2 pos = UV - vec2(pos_x, pos_y);
    float tb = 3.14*(0.5 + 0.5 * sin(TIME * 0.31 + 2.0));
    float rb = 0.15*(0.5 + 0.5 * sin(TIME * 0.41 + 3.0));
	
	
	color = vec3(archie_circle(UV));
	
	COLOR = vec4(color, 1.0);
	
}


