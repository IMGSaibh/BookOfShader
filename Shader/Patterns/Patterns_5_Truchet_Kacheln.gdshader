shader_type canvas_item;

vec2 tile (vec2 uv) {
	uv = fract(uv);
    return uv;
}

void fragment() {
	vec2 uv = UV;
	uv = tile(UV);
	
	COLOR = vec4(vec3(step(uv.x, uv.y)),1);
}
