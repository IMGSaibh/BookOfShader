shader_type canvas_item;
uniform float circleRadius : hint_range(0.0, 1.0);

float remapInterval(float value, float min1, float max1, float min2, float max2) {
  return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}

float DistanceOfPixel(vec2 uv){
    float pct = 0.0;
    // a. The DISTANCE from the pixel to the center
    //pct = distance(uv, vec2(0.5));

	
	// b. The LENGTH of the vector
	// from the pixel to the center
	//vec2 toCenter = vec2(0.5) - uv;
	//pct = length(toCenter);

	// c. The SQUARE ROOT of the vector
	// from the pixel to the center
	vec2 tC = vec2(0.5) - uv;
	pct = sqrt(tC.x*tC.x+tC.y*tC.y);
	
	return pct;
}

float DrawCricle(vec2 uv, float radius){
    float pct = 0.0;
    pct = distance(uv, vec2(0.5));
	float reMappedValue = remapInterval(pct, -0.5, 0.5, -1.0, 1.0);
	return step(radius, reMappedValue);
}
void fragment() {
	
	//float value = DistanceOfPixel(UV);
	//// remap from [-0.5, 0.5] to [-1.0, 1.0]
	//value = remapInterval(value, -0.5, 0.5, -1.0, 1.0);
	//COLOR = vec4(vec3(value), 1.0);
	
	vec4 color = vec4(1.0);
	float value = DrawCricle(UV, circleRadius);
	if(value > 0.0)
	{
		value = 0.0;
	}else
	{
		value = 1.0;
	}
	//float clampValue = clamp()
	COLOR = vec4(vec3(value), 1.0);
	//COLOR = vec4(vec3(DrawCricle(UV, circleRadius)), 1.0);
	//COLOR = vec4(1.0, 0.0, 0.0, DrawCricle(UV, circleRadius));
}
