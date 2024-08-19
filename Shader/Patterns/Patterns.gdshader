shader_type canvas_item;
uniform float radius : hint_range(0.0, 0.5);

float circle(in vec2 _uv, in float _radius){
    vec2 l = _uv - vec2(0.5);
    return 1.0 - smoothstep(_radius - (_radius * 0.01), _radius + (_radius*0.01), dot(l, l) * 4.0);
}
void fragment() {
    vec3 color = vec3(0.0);
	vec2 uv = UV;

	float column = 0.0;
	float row = 0.0;
	if(uv.y >= 0.66)
	{
		row = 1.0;
	}
	if(uv.x <= 0.33)
	{
		column = 1.0;
	}
	
    uv *= 3.0;      // Scale up the space by 3
    uv = fract(uv); // Wrap around 1.0    // Now we have 9 spaces that go from 0-1
	
	vec3 circle_color = vec3(column, row, 0.0);
	
    color = vec3(circle(uv, radius)) + circle_color;

	COLOR = vec4(color, 1.0);
}


