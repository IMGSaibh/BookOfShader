shader_type canvas_item;
uniform float circleRadius : hint_range(0.0, 1.0);

float remapInterval(float value, float min1, float max1, float min2, float max2) {
  return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}

float DistanceOfPixel(vec2 uv){
    float pct = 0.0;
    // a. The DISTANCE from the pixel to the center
    pct = distance(uv, vec2(0.5));
	pct = distance(uv,vec2(0.4)) + distance(uv,vec2(0.6));
	pct = distance(uv,vec2(0.4)) * distance(uv,vec2(0.6));
	pct = min(distance(uv,vec2(0.4)),distance(uv,vec2(0.6)));
	//pct = max(distance(uv,vec2(0.4)),distance(uv,vec2(0.6)));
	//pct = pow(distance(uv,vec2(0.4)),distance(uv,vec2(0.6)));
	
	// b. The LENGTH of the vector
	// from the pixel to the center
	//vec2 toCenter = vec2(0.5) - uv;
	//pct = length(toCenter);

	// c. The SQUARE ROOT of the vector
	// from the pixel to the center
	//vec2 tC = vec2(0.5) - uv;
	//pct = sqrt(tC.x*tC.x+tC.y*tC.y);
	
	return pct;
}

float DrawCricle(vec2 uv, float radius){
    float pct = 0.0;
    pct = distance(uv, vec2(0.5));
	// remap value to have colored pixel from 0.0 - 1.0
	float reMappedValue = remapInterval(pct, -0.5, 0.5, -1.0, 1.0);
	return reMappedValue;
}

float DrawCricle_Step(vec2 uv, float radius){
    float pct = 0.0;
    pct = distance(uv, vec2(0.5));
	float reMappedValue = remapInterval(pct, -0.5, 0.5, -1.0, 1.0);
	// sharpen the edge of circle 
	return step(radius, reMappedValue);
}

float DrawCricle_Step_Smoothstep_Inverted(vec2 uv, float radius){
    float pct = 0.0;
    pct = distance(uv, vec2(0.5));
	float reMappedValue = remapInterval(pct, -0.5, 0.5, -1.0, 1.0);
	// sharpen the edge of circle
	reMappedValue = step( radius, reMappedValue);
	// invert with smoothstep
	return smoothstep(1.0, 0.0, reMappedValue);
}

float DrawCricle_Smoothstep_InvertColor(vec2 uv, float radius){
    float pct = 0.0;
    pct = distance(uv, vec2(0.5));
	float reMappedValue = remapInterval(pct, -0.5, 0.5, -1.0, 1.0);
	return smoothstep(radius, 0.0, reMappedValue);
}

float DrawCricle_Displacement(vec2 uv, float radius, vec2 displacement){
    float pct = 0.0;
    pct = distance(uv, displacement);
	float reMappedValue = remapInterval(pct, -0.5, 0.5, -1.0, 1.0);
	// sharpen the edge of circle
	reMappedValue = step( radius, reMappedValue);
	// invert with smoothstep
	return smoothstep(1.0, 0.0, reMappedValue);
}

float DrawCricle_Perfomance(in vec2 uv, in float radius){
	// sqrt and all functions that depend on it are very expensive
	// we draw circle using the dot product. This is faster 
    vec2 dist = uv - vec2(0.5);
	// 1.0 - smoothstep inverts color
	// radius - (radius * 0.01) sharpen the edges of smoothstep while * 0.01 is for radius - radius is not 0
	// * 4.0 scales so that circle is drawn until the texture edges
	return 1.0 - smoothstep(radius - (radius * 0.01), radius + (radius * 0.01), dot(dist, dist) * 4.0);
}

void fragment() {
	
	float value = DistanceOfPixel(UV);
	// remap from [-0.5, 0.5] to [-1.0, 1.0]
	value = remapInterval(value, -0.5, 0.5, -1.0, 1.0);
	COLOR = vec4(vec3(value), 1.0);
	
	//COLOR = vec4(vec3(DrawCricle(UV, circleRadius)), 1.0);
	//COLOR = vec4(vec3(DrawCricle_Step(UV, circleRadius)), 1.0);
	//COLOR = vec4(vec3(DrawCricle_Step_Smoothstep_Inverted(UV, circleRadius)), 1.0);
	//COLOR = vec4(vec3(DrawCricle_Smoothstep_InvertColor(UV, circleRadius)), 1.0);
	//COLOR = vec4(1.0, 0.0, 0.0, DrawCricle_Smoothstep_InvertColor(UV,circleRadius));
	//COLOR = vec4(1.0, 0.0, 0.0, DrawCricle_Smoothstep_InvertColor(UV, sin(TIME*5.0) + 1.0));
	//COLOR = vec4(0.0, DrawCricle_Step_Smoothstep_Inverted(UV, circleRadius),0.0, 1.0);
	//
	//vec4 circle_1 = vec4(vec3(DrawCricle_Displacement(UV, circleRadius, vec2(0.3, 0.3))), 1.0);
	//vec4 circle_2 = vec4(vec3(DrawCricle_Displacement(UV, circleRadius, vec2(0.3, 0.7))), 1.0);
	//vec4 circle_3 = vec4(vec3(DrawCricle_Displacement(UV, circleRadius, vec2(0.7, 0.7))), 1.0);
	//COLOR = circle_1 + circle_2 +  circle_3;
	
	//COLOR = vec4(vec3(DrawCricle_Perfomance(UV, circleRadius)), 1.0);
	

}
