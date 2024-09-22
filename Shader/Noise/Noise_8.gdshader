shader_type canvas_item;

// 2D Random
float random_2D (in vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
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
	vec3 color = vec3(0.0);
	vec2 uv = UV * 1.0;
    vec2 pos = vec2(uv * 10.0);

    float DF = 0.0;

    // Add a random position
    float a = 0.0;
    vec2 vel = vec2(TIME * 0.1);
    DF += noise(pos + vel) * 0.25 + 0.25;
 
    // Add a random position
    a = noise(pos * vec2(cos(TIME * 0.15), sin(TIME * 0.1)) * 0.1) * 3.1415;
    vel = vec2(cos(a),sin(a));
    DF += noise(pos + vel) * 0.25 + 0.25;

    color = vec3(smoothstep(0.7, 0.75, fract(DF)));
	COLOR = vec4(color, 1.0);
}

