shader_type canvas_item;
uniform vec2 mouse_xy;

void fragment() {

    vec2 u_resolution = 1.0 / SCREEN_PIXEL_SIZE;
    vec3 color = vec3(0.0);
	
    vec2 translate = vec2(cos(TIME), sin(TIME));
	
    // Cell positions
    vec2 point[5];
    point[0] = vec2(0.83, 0.75) +  translate * 0.25;
    point[1] = vec2(0.60, 0.07) +  translate * 0.5;
    point[2] = vec2(0.28, 0.64) + translate * 0.2;
    point[3] =  vec2(0.31, 0.26) + translate * 0.1;
    point[4] = mouse_xy/u_resolution;
    
    float m_dist = 1.;  // minimum distance

    // Iterate through the points positions
    for (int i = 0; i < 5; i++) {
        float dist = distance(UV, point[i]);

        // Keep the closer distance
        m_dist = min(m_dist, dist);
    }

    // Draw the min distance (distance field)
    color += m_dist;

    // Show isolines
    //color -= step(.7,abs(sin(50.0*m_dist)))*.3;

    COLOR = vec4(color,1.0);
}
