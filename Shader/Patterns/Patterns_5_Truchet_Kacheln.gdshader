shader_type canvas_item;
uniform int truchetTiling : hint_range(0, 10);
uniform float hStripeThickness : hint_range(0.01, 0.1);

uniform float pos_x : hint_range(0.0, 1.0);
uniform float pos_y : hint_range(0.0, 1.0);
uniform float size_1_distance_field : hint_range(0.0, 0.5);

const float SQUARE_SIZE = 0.12;

float getQuantizedSinValue(float sinValue) {
    // Wir teilen den Bereich von 0 bis 1 in drei gleich große Intervalle auf
    return floor(sinValue * 5.0) * 0.5 + 0.5;
}

float tileHorizontal(vec2 uv, int _truchetTiling, float sinusValue) {
	uv *= float(_truchetTiling);
	uv = fract(uv);
	float rectAngle = 0.0;
	float vStripes_1 = 0.0;
	float vStripes_2 = 0.0;
	
	float hStripes_0 = 0.0;
	float hStripes_1 = 0.0;
	float hStripes_2 = 0.0;
	float hStripes_3 = 0.0;
	float hStripes_4 = 0.0;
	vStripes_1 = step(0.01 - hStripeThickness, uv.x) - step(0.06  + hStripeThickness, uv.x);
	vStripes_2 = step(0.91 - hStripeThickness, uv.x) - step(0.99  + hStripeThickness, uv.x);
	
	hStripes_0 = step(0.01 - hStripeThickness + 0.0, uv.y) - step(0.02  + hStripeThickness + 0.02, uv.y);
	hStripes_1 = step(0.01 - hStripeThickness + 0.23, uv.y) - step(0.02  + hStripeThickness + 0.23, uv.y);
	hStripes_2 = step(0.01 - hStripeThickness + 0.48, uv.y) - step(0.02  + hStripeThickness + 0.48, uv.y);
	hStripes_3 = step(0.01 - hStripeThickness + 0.73, uv.y) - step(0.02  + hStripeThickness + 0.73, uv.y);
	hStripes_4 = step(0.01 - hStripeThickness + 0.92, uv.y) - step(0.02  + hStripeThickness + 0.97, uv.y);
	
	vec2 squarePos = uv - vec2(pos_x, pos_y);
	//The abs() function makes negative numbers positive - it flips them around zero. 
	//Since our uv coordinate is negative to the left and above, taking abs() from it
	//and setting red to c.x and green to c.y results in a symmetrical image around the center
	vec2 r = abs(squarePos.xy);
	float s = max(r.x, r.y);
	float square = step(size_1_distance_field, s) * step(s, SQUARE_SIZE);
	
	float result = vStripes_1 + vStripes_2 + hStripes_0 + hStripes_1 + hStripes_2 + hStripes_3 + hStripes_4 + square;
	
    return result;
}

void fragment() {
	vec2 uv = UV;
	COLOR = vec4(vec3(tileHorizontal(UV, truchetTiling, sin(TIME))),1);
}
