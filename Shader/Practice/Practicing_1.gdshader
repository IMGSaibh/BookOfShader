//https://www.youtube.com/watch?v=f4s1h2YETNY&t=11s
shader_type canvas_item;
uniform float glow : hint_range(0.0, 0.1);
uniform float zoom_out : hint_range(0.0, 1.0);


vec3 palette( in float t)
{
	vec3 a = vec3(0.5, 0.5, 0.5);
	vec3 b = vec3(0.5, 0.5, 0.5);
	vec3 c = vec3(1.0, 1.0, 1.0);
	vec3 d = vec3(0.263, 0.461, 0.557);
	
    return a + b * cos( 6.28318 * (c * t + d));
}


void fragment() {	
	vec3 color = vec3(0.0);
	vec3 final_color = vec3(0.0);
	vec2 pos = UV * 2.0 - 1.0;
	
	vec2 original_pos = pos;
	for(float i = 0.0; i < 4.0; i++)
	{
		//scale uv
		pos *= 2.0;
		//devide uv in 4 quadrants. but we have more because of preceding scaling
		pos = fract(pos * zoom_out);
		// re-positioning each uv sqaure
		pos -= 0.5;
		
		float dist = length(pos);
		dist *= exp(-length(original_pos));
		color = palette(length(original_pos) + i * 0.3 + TIME * 0.3);
		
		
		dist = sin(dist * 8.0 + TIME)/8.0;
		dist = abs(dist);
		dist = pow(glow/dist, 1.0);
		 
		final_color += color * dist;
	}
	
	COLOR = vec4(final_color, 1.0);
}
