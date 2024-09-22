shader_type canvas_item;
uniform float pos_x : hint_range(0.0, 1.0);
uniform float pos_y : hint_range(0.0, 1.0);
uniform float size : hint_range(0.0, 1.0);

float box(in vec2 _uv, in vec2 _size){
    _size = vec2(0.5) - _size * 0.5;
    vec2 uv = smoothstep(_size, _size + vec2(0.001), _uv);
    uv *= smoothstep(_size, _size + vec2(0.001), vec2(1.0) - _uv);
    return uv.x * uv.y;
}

float draw_cross(in vec2 _uv, float _size){
    return  box(_uv, vec2(_size, _size / 4.0)) + box(_uv, vec2(_size / 4.0, _size));
}

mat2 rotate2d(float _angle){
    return mat2(vec2(cos(_angle), -sin(_angle)), 
				vec2(sin(_angle), cos(_angle)));
}

mat2 scale(vec2 _scale){
    return mat2(vec2(_scale.x, 0.0),
                vec2(0.0, _scale.y));
}

vec2 random2(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)), dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43758.5453123);
}

// Gradient Noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/XdXGW8
float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( dot( random2(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ),
                     dot( random2(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( random2(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ),
                     dot( random2(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}

void fragment() {
	vec3 color = vec3(0.0);
	vec2 pos = UV - vec2(pos_x, pos_y);
	
    // To move the cross we move the space.
    vec2 translate = vec2(cos(TIME), sin(TIME));
    pos += translate * 0.25 + noise(UV);
	
	// move space from the center to the vec2(0.0)
    pos -= vec2(0.5);
    
	// rotate the space
    pos = rotate2d( sin(TIME) * PI ) * pos;
    pos = scale( vec2(sin(TIME) + 1.0) ) * pos + noise(UV);
    
	// move it back to the original place
    pos += vec2(0.5);
	
	// Show the coordinates of the space on the background
    color = vec3(pos.x, pos.y, 0.0);
	
	color += vec3(draw_cross(pos, size));
	COLOR = vec4(color, 1.0);
}