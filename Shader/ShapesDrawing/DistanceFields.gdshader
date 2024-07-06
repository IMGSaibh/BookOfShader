shader_type canvas_item;
uniform float offset : hint_range(0.0, 1.0);
uniform float waves : hint_range(0.0, 10.0);

vec4 DrawingDistanceFunction(vec2 uv, float _waves, float _offset){
	//vec2 st = uv;	
	vec3 color = vec3(0.0);
	float d = 0.0;

	// Remap the space to -1. to 1.
	uv = uv * 2.0 - 1.0;

	// Make the distance field
	d = length(abs(uv) -_offset);
	//d = length(min(abs(uv) - _offset, 0.0));
	//d = length(max(abs(uv) - _offset, 0.0));
	
	// Visualize the distance field
	return vec4(vec3(fract(d * _waves)),1.0);
	//return vec4(vec3( step(0.3, d) ), 1.0);
	//return vec4(vec3( step(0.3, d) * step(d, 0.4)), 1.0);
	//return vec4(vec3( smoothstep(0.3, 0.4,d) * smoothstep(0.6, 0.5,d)) ,1.0);
}

vec4 DrawingDistanceFunctionScreenCoords(vec2 uv, float _waves, float _offset, vec2 screenPixelSize, vec4 fragCoord){
	
	vec2 u_resolution = 1.0/screenPixelSize;
	vec2 st = fragCoord.xy/u_resolution.xy;
	st.x *= u_resolution.x/u_resolution.y;
	vec3 color = vec3(0.0);
	float d = 0.0;

	// Remap the space to -1. to 1.
	st = st *2.-1.;

	// Make the distance field
	d = length(abs(st) -_offset);
	//d = length(min(abs(st) - _offset, 0.0));
	//d = length(max(abs(st) - _offset, 0.0));
	
	// Visualize the distance field
	return vec4(vec3(fract(d * _waves)),1.0);
	//return vec4(vec3( step(0.3, d) ), 1.0);
	//return vec4(vec3( step(0.3, d) * step(d, 0.4)), 1.0);
	//return vec4(vec3( smoothstep(0.3, 0.4,d) * smoothstep(0.6, 0.5,d)) ,1.0);
}

void fragment() {
	vec2 screenPixelSize = SCREEN_PIXEL_SIZE;
	vec4 fragCoord = FRAGCOORD;
	COLOR = DrawingDistanceFunction(UV, waves, offset);
	//COLOR = DrawingDistanceFunctionScreenCoords(UV, waves, offset, screenPixelSize, fragCoord);
}