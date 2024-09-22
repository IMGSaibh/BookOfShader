shader_type canvas_item;

float random (in vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

// Value noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/lsf3WH
float value_noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
    vec2 u = f*f*(3.0-2.0*f);
    return mix( mix( random( i + vec2(0.0,0.0) ),
                     random( i + vec2(1.0,0.0) ), u.x),
                mix( random( i + vec2(0.0,1.0) ),
                     random( i + vec2(1.0,1.0) ), u.x), u.y);
}

mat2 rotate2d(float angle){
    return mat2(vec2(cos(angle),-sin(angle)),
                vec2(sin(angle),cos(angle)));
}

float lines(in vec2 pos, float b){
    float scale = 6.0;
    pos *= scale;
    return smoothstep(0.0, 0.5 + b * 0.5, abs((sin(pos.x * 3.1415) + b * 2.0)) * 0.5);
}

vec4 wood_texture(vec2 uv)
{
    vec2 pos = uv.yx * vec2(10.0, 3.0);
    float pattern = pos.x;
    // Add noise
    pos = rotate2d( value_noise(pos) ) * pos;
    // Draw lines
    pattern = lines(pos,.5);
	vec3 color = vec3(pattern);
	return vec4(color, 1.0);
}



void fragment() {

	COLOR = wood_texture(UV);
	
	
}


