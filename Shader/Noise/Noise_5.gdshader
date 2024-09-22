shader_type canvas_item;

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

vec4 wood_texture(vec2 uv)
{
    vec3 color = vec3(0.0);
    float t = 0.8;
    // Uncomment to animate
     t = abs(1.0-sin(TIME * 0.8))*5.;
    // Comment and uncomment the following lines:
    uv += noise(uv * 2.0) * t; // Animate the coordinate space
    color = vec3(1.0) * smoothstep(0.18, 0.2,noise(uv)); // Big black drops
    color += smoothstep(0.15, 0.2,noise(uv * 10.0)); // Black splatter
    color -= smoothstep(0.35, 0.4,noise(uv * 10.0)); // Holes on splatter
	return vec4(1.0 - color, 1.0);
}

void fragment() {
	
	COLOR = wood_texture(UV);
}

