shader_type canvas_item;
float random_1 (in float x) {
    return fract(sin(x)*1e4);
}

float random_2 (in vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233)))* 43758.5453123);
}

float pattern(vec2 st, vec2 v, float t) {
    vec2 p = floor(st+v);
    return step(t, random_2(100.0 + p * 0.000001) + random_1(p.x) * 0.5 );
}
void fragment() {

    vec2 grid = vec2(100.0, 50.0);
	vec2 uv = UV;
    uv *= grid;

    vec2 ipos = floor(uv);  // integer
    vec2 fpos = fract(uv);  // fraction

    vec2 vel = vec2(TIME * 2.0 * max(grid.x, grid.y)); // time
    vel *= vec2(-1.0, 0.0) * random_1(1.0 + ipos.y); // direction

    // Assign a random value base on the integer coord
    vec2 offset = vec2(0.1,0.);

    vec3 color = vec3(0.);
    color.r = pattern(uv + offset, vel,0.5);
    color.g = pattern(uv, vel,0.5);
    color.b = pattern(uv - offset, vel, 0.5);
	
    // Margins
    color *= step(0.2,fpos.y);

    COLOR = vec4(1.0-color,1.0);

}

