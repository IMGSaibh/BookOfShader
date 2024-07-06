shader_type canvas_item;

vec3 circle(vec2 uv, float time){
	vec2 pos = uv - vec2(0.5);
	float r = length(pos) * 2.0;
	float a = atan(pos.y, pos.x);
	a += time;
	float f = sin(a * 4.0);
	 //f = abs(cos(a * 5.0));
     //f = abs(cos(a * 2.5)) * 0.5 + 0.3;
     //f = abs(cos(a * 12.0) * sin(a * 3.0)) * 0.8 + 0.1;
     f = smoothstep(-0.1, 0.2, cos(a * 8.0)) * 0.2 + 0.5;
	return vec3(1.0 - smoothstep(f, f + 0.01, r));
}

void fragment() {
	COLOR = vec4(circle(UV, TIME), 1.0);
}

