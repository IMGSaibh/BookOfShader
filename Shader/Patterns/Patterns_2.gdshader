shader_type canvas_item;

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
    vec2 aa = vec2(_smoothEdges*0.5);
    vec2 uv_local = smoothstep(_size,_size+aa, uv);
    uv_local *= smoothstep(_size,_size + aa,vec2(1.0) - uv);
    return uv_local.x * uv_local.y;
}

void fragment() {
	vec2 uv = UV;
	vec3 color = vec3(0.0);

	// Divide the space in 4
	uv = tile(uv, 4.0);

	// Use a matrix to rotate the space 45 degrees
	uv = rotate2D(uv, PI * 0.25);

	// Draw a square
	color = vec3(box(uv, vec2(0.7), 0.01));
	// color = vec3(st,0.0);

	COLOR = vec4(color,1.0);
}
