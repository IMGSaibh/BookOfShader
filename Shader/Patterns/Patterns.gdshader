shader_type canvas_item;
uniform float radius : hint_range(0.0, 0.5);

float circle(in vec2 _uv, in float _radius){
    vec2 l = _uv - vec2(0.5);
    return 1.0 - smoothstep(_radius - (_radius * 0.01), _radius + (_radius*0.01), dot(l, l) * 4.0);
}
void fragment() {
    vec3 color = vec3(0.0);
	vec2 uv = UV;
    uv *= 3.0;      // Scale up the space by 3
    uv = fract(uv); // Wrap around 1.0

    // Now we have 9 spaces that go from 0-1

    color = vec3(uv, 0.0);
    color = vec3(circle(uv, 0.5));

	COLOR = vec4(color,1.0);
}


