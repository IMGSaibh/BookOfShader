shader_type canvas_item;
const float TWO_PI = 6.28318530718;
uniform float left_side : hint_range(0.0, 1.0);
uniform float right_side : hint_range(0.0, 1.0);
uniform float top_side : hint_range(0.0, 1.0);
uniform float bottom_side : hint_range(0.0, 1.0);

uniform float rect_offset_1 : hint_range(0.0, 1.0);
uniform float rect_offset_2 : hint_range(0.0, 1.0);

uniform float scale : hint_range(0.0, 400.0);

float random_1D (in float x) {
   return fract(sin(x)*1e4);
}

// 2D Random
float random_2D (in vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

float rectangle(vec2 uv, float _left_side, float _right_side, float _bottom_side, float _top_side)
{
	float result = 0.0; 
	float side_left = step(_left_side, uv.x);
	float side_b = 1.0 - step(1.0 - _right_side, uv.x);
	float side_c = step(_top_side, uv.y);
	float side_d = 1.0 - step(1.0 - _bottom_side, uv.y);
	return result = side_left * side_b * side_c * side_d;
}

// 2D Noise based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random_2D(i);
    float b = random_2D(i + vec2(1.0, 0.0));
    float c = random_2D(i + vec2(0.0, 1.0));
    float d = random_2D(i + vec2(1.0, 1.0));

    // Smooth Interpolation
    // Cubic Hermine Curve.  Same as SmoothStep()
    vec2 u = f * f * (3.0 - 2.0 * f);
    u = smoothstep(0.0, 1.0, f);

    // Mix 4 coorners percentages
    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

void fragment() {
	float rect_1 = rectangle(UV, left_side, right_side, bottom_side, top_side);
	float rect_2 = rectangle(UV, left_side + rect_offset_1, right_side - rect_offset_1, bottom_side, top_side);
	float rect_3 = rectangle(UV, left_side + rect_offset_2, right_side - rect_offset_2, bottom_side, top_side);
	// Use the noise function
    float n = noise(UV * scale);
	vec4 color_rnd = vec4(vec3(n), 1.0);
	
	vec4 color_1 = vec4(vec3(0.0, 1.0, 0.9),1.0);
	vec4 rects = vec4(vec3(rect_1 + rect_2 + rect_3), 1.0) * vec4(vec3(1.0, 0.0, 0.0), 1.0);
	
	vec4 mixed_color = mix(color_1, rects, color_rnd);
	COLOR = rects * color_rnd * color_1;
	COLOR = mixed_color;
}

















