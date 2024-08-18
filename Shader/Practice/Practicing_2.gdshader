//https://www.youtube.com/watch?v=f4s1h2YETNY&t=11s
shader_type canvas_item;
uniform float glow : hint_range(0.0, 0.1);
uniform float rings : hint_range(0.0, 15.0);


void fragment() {
	vec2 iResolution = 1.0/TEXTURE_PIXEL_SIZE.xy;
	vec2 iResolution_x_screen = 1.0/SCREEN_PIXEL_SIZE.xy;
	
	vec2 pos_uv_coord = UV * 2.0 - 1.0;
	//pos.x *= iResolution_x_screen.y / iResolution.x;
	
	float d = length(pos_uv_coord);
	d = sin(d * rings);
	// negative integers tun into positves an we get a white color in the middle
	d = abs(d);
	// sharpen the ring
	//d = smoothstep(0.0, 0.1, d);
	
	// sharpen the ring and make it more glow 
	d =  0.1/d;
	vec3 final_color = vec3(0.0, 1.0, 1.0) * d;
	COLOR = vec4(final_color, 1.0);
}

