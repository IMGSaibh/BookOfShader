shader_type canvas_item;
vec2 random2( vec2 p ) {
    return fract(sin(vec2(dot(p,vec2(127.1,311.7)),dot(p,vec2(269.5,183.3)))) * 43758.5453);
}
void fragment() {
    vec3 color = vec3(0.0);
	vec2 uv = UV;
    // Scale
    uv *= 5.0;

    // Tile the space
    vec2 i_st = floor(uv);
    vec2 f_st = fract(uv);

    float m_dist = 10.0;  // minimum distance
    vec2 m_point;        // minimum point

    for (int j=-1; j<=1; j++ ) {
        for (int i=-1; i<=1; i++ ) {
            vec2 neighbor = vec2(float(i),float(j));
            vec2 point = random2(i_st + neighbor);
            point = 0.5 + 0.5 * sin(TIME + 6.2831 * point);
            vec2 diff = neighbor + point - f_st;
            float dist = length(diff);

            if( dist < m_dist ) {
                m_dist = dist;
                m_point = point;
            }
        }
    }

    // Assign a color using the closest point position
    color += dot(m_point,vec2(0.3, 0.6));

    // Add distance field to closest point center
    // color.g = m_dist;

    // Show isolines
    color -= abs(sin(40.0 * m_dist)) * 0.07;

    // Draw cell center
    color += 1.0 - step(0.05, m_dist);

    // Draw grid
    color.r += step(0.98, f_st.x) + step(0.98, f_st.y);

    COLOR = vec4(color,1.0);
}
