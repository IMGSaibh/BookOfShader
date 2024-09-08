shader_type canvas_item;
#define TWO_PI 6.28318530718
uniform float pos_x : hint_range(0.0, 1.0);
uniform float pos_y : hint_range(0.0, 1.0);
uniform int corner_count : hint_range(0.0, 10.0);
uniform float size_1_distance_field : hint_range(0.0, 0.5);
uniform float size_2_distance_field : hint_range(0.0, 0.5);
uniform float size_angle_based : hint_range(0.0, 0.5);


vec4 square_distance_field(vec2 uv)
{	
	vec2 pos = uv - vec2(pos_x, pos_y);
	//The abs() function makes negative numbers positive - it flips them around zero. 
	//Since our uv coordinate is negative to the left and above, taking abs() from it
	//and setting red to c.x and green to c.y results in a symmetrical image around the center
	vec2 r = abs(pos.xy);
	//return vec4(r, 0.0, 1.0);
	
	//max returns r.x or r.y depenmding on which is larger. 
	//float s = max(r.x, r.y);	
	
	//This distance field can give us different kinds of squares
	//float s = step(0.3, max(r.x, r.y));
	//return vec4(vec3(s), 1.0);

	float s = max(r.x, r.y);
	float step_multiply_step = step(size_1_distance_field, s) * step(s, size_2_distance_field);
	float step_multiply_smoothstep = smoothstep(size_1_distance_field,0.51, s) * smoothstep(0.51, size_2_distance_field, s); 
	return vec4(vec3(step_multiply_step), 1.0);
}

vec4 rounded_square(vec2 uv){
	vec2 pos = uv - vec2(pos_x, pos_y);
	//float r = length(max(abs(pos) - 0.1, 0.0));
	float r = step(0.1, length(max(abs(pos) - 0.1,0.0)));
	return vec4(r, r, r, 1.0);
}

//The nice thing about this approach is that with a different scale factor, 
//it can give us ANY regular polygon, not just a square. 
//It's also easy to rotate with an offset to the angle.
vec4 square_angle_based(vec2 uv)
{
	vec2 pos = uv - vec2(pos_x, pos_y);
	//First we find the angle of each point using the atan function
	float angle = atan(pos.x, pos.y);
	//Then we scale the angle to be in the range -1.5 to 2.5 and then round it down to the nearest integer using the floor function
	float step_angle_based = step(size_angle_based, cos( floor(angle * 0.636 + 0.5) * 1.57 - angle) * length(pos));
	//We then turn that back into an angle and subtract the difference between that and the actual angle. 
	//Taking cos() of that difference and multiplying by the length of the original point gives 
	//the distance of that point along the vector for the centre line of the quadrant. 
	//Finally a step turns that into a square
	return vec4(vec3(step_angle_based), 1.0);
}
vec4 square_angle_based_parameterised(vec2 uv, int N)
{
	vec2 pos = uv - vec2(pos_x, pos_y);
	float angle = atan(pos.x, pos.y) + 0.2;
	float b = 6.28319/float(N);
	float step_angle_based = smoothstep(size_angle_based, size_angle_based + 0.01, cos(floor(0.5 + angle / b) * b - angle) * length(pos));
	return vec4(vec3(step_angle_based), 1.0);
}

vec3 draw_shape(vec2 uv, int corners_count)
{
	float dist = 0.0;
			
	vec2 pos = uv - vec2(pos_x, pos_y);

	// Angle and radius from the current pixel
	float angle = atan(pos.x, pos.y) + PI;
	float corner_calc = TWO_PI/float(corners_count);

	// Shaping function that modulate the distance
	dist = cos(floor(0.5 + angle / corner_calc) * corner_calc - angle) * length(pos);
	return vec3(1.0 - smoothstep(size_angle_based, size_angle_based + 0.01, dist));
}

void fragment() {

	COLOR = square_distance_field(UV);
	//COLOR = rounded_square(UV);
	//COLOR = square_angle_based(UV);
	//COLOR = square_angle_based_parameterised(UV, corner_count);
	
	COLOR = vec4(draw_shape(UV, corner_count), 1.0);

}

