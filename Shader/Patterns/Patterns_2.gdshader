shader_type canvas_item;
uniform float size : hint_range(0.0, 2.0);
uniform float smooth_edges : hint_range(0.0, 1.0);
uniform float angle : hint_range(0.0, 1.0);

vec3 palette( in float t)
{
	vec3 a = vec3(0.5, 0.5, 0.5);
	vec3 b = vec3(0.5, 0.5, 0.5);
	vec3 c = vec3(1.0, 1.0, 1.0);
	vec3 d = vec3(0.263, 0.461, 0.557);
	
    return a + b * cos( 6.28318 * (c * t + d));
}

vec2 rotate2D(vec2 uv, float _angle){
    uv -= 0.5;
    uv =  mat2(vec2(cos(_angle), -sin(_angle)), 
				vec2(sin(_angle), cos(_angle))) * uv;
    uv += 0.5;
    return uv;
}

vec2 tile(vec2 uv, float _zoom){
    uv *= _zoom;
    return fract(uv);
}

float box(vec2 uv, vec2 _size, float _smoothEdges){
    _size = vec2(0.5) - _size * 0.5;
    vec2 aa = vec2(_smoothEdges * 0.5);
    vec2 uv_local = smoothstep(_size, _size + aa, uv);
    uv_local *= smoothstep(_size, _size + aa,vec2(1.0) - uv);
    return uv_local.x * uv_local.y;
}

void fragment() {
	vec2 uv = UV;
	vec3 color = vec3(0.0);

	// Divide the space in 4
	uv = tile(uv, 4.0);

	// Use a matrix to rotate the space 45 degrees
	uv = rotate2D(uv, PI * angle);

	// Draw a square
	color = vec3(box(uv, vec2(size), smooth_edges)) * vec3(palette(sin(TIME)));

	COLOR = vec4(color,1.0);
}
