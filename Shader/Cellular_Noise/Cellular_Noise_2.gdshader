shader_type canvas_item;
vec2 random2( vec2 p ) {
    return fract(sin(vec2(dot(p,vec2(127.1,311.7)),dot(p,vec2(269.5,183.3))))*43758.5453);
}

void fragment() {
	vec3 color = vec3(0.0);
	vec2 uv = UV;
	
	uv *= 5.0;
	
	// Tile the space
    vec2 i_st = floor(uv);
    vec2 f_st = fract(uv);
    float m_dist = 1.0;  // minimum distance

    for (int y= -1; y <= 1; y++) {
        for (int x= -1; x <= 1; x++) {
            // Neighbor place in the grid
            vec2 neighbor = vec2(float(x),float(y));

            // Random position from current + neighbor place in the grid
            vec2 point = random2(i_st + neighbor);
			// Animate the point
            point = 0.5 + 0.5 * sin(TIME + 6.2831 * point);
			
			
			// Vector between the pixel and the point
            vec2 diff = neighbor + point - f_st;

            // Distance to the point
            float dist = length(diff);

            // Keep the closer distance
            m_dist = min(m_dist, dist);
        }
    }
	
    // Draw the min distance (distance field)
    color += m_dist;

    // Draw cell center
    color += 1.0 - step(0.02, m_dist);

    // Draw grid
    color.r += step(0.98, f_st.x) + step(0.98, f_st.y);

    // Show isolines
     //color -= step(0.7,abs(sin(27.0 * m_dist))) * 0.5;

    COLOR = vec4(color, 1.0);
}
