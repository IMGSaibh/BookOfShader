shader_type canvas_item;

vec3 rgb2hsb( in vec3 c ){
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz),
                 vec4(c.gb, K.xy),
                 step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r),
                 vec4(c.r, p.yzx),
                 step(p.x, c.r));
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)),
                d / (q.x + e),
                q.x);
}

//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc
vec3 hsb2rgb( in vec3 c ){
	// hue = 
	// satuartion = Saturation is the intensity of a hue from gray tone (no saturation) to pure, vivid color (high saturation)
	// brightness = is the relative lightness or darkness of a particular color. from black (no brightness) to white (full brightness)
	// vec3 represents vec3(hue, satuartion, brightness)
	// clamp(float x, maxVal, maxVal) x cant be under min and over max
	// abs() is always positive value
    vec3 rgb = clamp(abs(mod(c.x * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
    rgb = rgb * rgb * (3.0 - 2.0 * rgb);
    return c.z * mix(vec3(1.0), rgb, c.y);
}

void fragment() {
    // We map x (0.0 - 1.0) to the hue (0.0 - 1.0)
    // And the y (0.0 - 1.0) to the brightness
    //COLOR = vec4(rgb2hsb(hsb2rgb(vec3(UV.x, 1.0, UV.y))), 1.0);
    //COLOR = vec4(hsb2rgb(vec3(UV.x, 1.0, UV.y)), 1.0);
	
    float shapedHue = UV.x;
	// rearange color stripes
    //float shapedHue = pow(UV.x, 5.0);
    //float shapedHue = fract(0.1);
    //float shapedHue = smoothstep(0.1,0.9, UV.x);
	//shapedHue = mod(shapedHue, 0.5);
	//TODO: change colors so that red and green are opposite each other
    COLOR = vec4(hsb2rgb(vec3(shapedHue, 1.0, UV.y)), 1.0);
}

