shader_type canvas_item;
uniform float pos_cutout_x : hint_range(0.0, 1.0);
uniform float pos_cutout_y : hint_range(0.0, 1.0);

uniform float pos_x : hint_range(0.0, 1.0);
uniform float pos_y : hint_range(0.0, 1.0);
uniform float size : hint_range(-0.5,0.5);
uniform float gear_size : hint_range(0.0,2.0);
uniform float gear_count : hint_range(0.0,12.0);
uniform float cutout_circle_size : hint_range(0.0,0.5);


vec3 circle(vec2 uv, float time){
	vec2 pos = uv - vec2(pos_x, pos_y);
	float r = length(pos);
	float atan_angle = atan(pos.y, pos.x);
	
	//excersise 1
	//atan_angle += time;
	
	float f = sin(atan_angle * 4.0);
	//f = abs(cos(atan_angle * 5.0));
    //f = abs(cos(atan_angle * 2.5)) * 0.5 + 0.3;
    //f = abs(cos(atan_angle * 12.0) * sin(atan_angle * 3.0)) * 0.8 + 0.1;
	f = smoothstep(-0.1, 0.2, cos(atan_angle * gear_count)) * 0.03 + gear_size;
    
	//excersise 2
	vec2 pos_cutout_circle_1 = uv - vec2(pos_cutout_x, pos_cutout_y);
	float dist_1 = distance(vec2(0.0), pos_cutout_circle_1);
	float cutout_circle_1 = 1.0 - step(cutout_circle_size, dist_1);
	
	vec2 pos_cutout_circle_2 = uv - vec2(0.6, 0.6);
	float dist_2 = distance(vec2(0.0), pos_cutout_circle_2);
	float cutout_circle_2 = 1.0 - step(cutout_circle_size, dist_2);
	
	
	return vec3(1.0 - smoothstep(f, f + 0.01, r) - cutout_circle_1 - cutout_circle_2);
	
	return vec3(1.0 - smoothstep(f, f + 0.01, r));
}

void fragment() {
	COLOR = vec4(circle(UV, TIME), 1.0);
}

