shader_type canvas_item;

float stripe(vec2 uv) {
    return cos(uv.x * 20.0 - TIME + uv.y * -30.0);
}

float glass(vec2 uv) {
    return cos(dot(uv.xy, vec2(12.41234, 2442.123)) * cos(uv.y));
}
void fragment() {
	vec2 uv = UV;
	float i_res_x = 1.0 / TEXTURE_PIXEL_SIZE.x;
	float i_res_y = 1.0 / TEXTURE_PIXEL_SIZE.y;
    float a = i_res_x/i_res_y;
    uv.x *= a;
    
    float g = stripe(uv);

    vec3 col = vec3(smoothstep(0.0, 0.2, g));
    col.r = 0.8;
    col /= (pow(glass(vec2(uv.x * 30.0, uv.y)), 2.0)) + 0.5;
    
  
    //Mask sides
    col *= smoothstep(0.12, 0.0, abs(uv.x - 0.5 * a));

    //Mask top and bottom
    col *= smoothstep(0.33, 0.3, abs(uv.y - 0.5));

    if (uv.y > 0.80 && uv.y < 0.94 || uv.y < 0.2 && uv.y > 0.06) {
       col = vec3(smoothstep(0.13, 0.0, abs(uv.x - 0.5 * a)));
    }

    if (uv.y > 0.77 && uv.y < 0.87 || uv.y < 0.23 && uv.y > 0.13) {
       col = vec3(smoothstep(0.15, 0.0, abs(uv.x - 0.5 * a)));
    }

	COLOR = vec4(col, 1.0);
}
