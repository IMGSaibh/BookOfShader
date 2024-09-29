shader_type canvas_item;
#define TWO_PI 6.28318530718

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
vec4 HsbToPolarCoords(vec2 uv, float time){
	
	vec3 color = vec3(0.0);
	// To map our HSB function to polar coordinates we need to obtain 
	// the angle and distance from the center of the billboard to the pixel coordinate
    // Use polar coordinates instead of cartesian
    vec2 toCenter = vec2(0.5) - uv;
	// will return an angle in radians between -PI and PI
    float angle = atan(toCenter.y, toCenter.x);
    float radius = length(toCenter) * 2.0;
 	angle += time;
    // Map the angle (-PI to PI) to the Hue (from 0 to 1)
    // and the Saturation to the radius
	//divide angle by TWO_PI to get values between -0.5 to 0.5
    //color = hsb2rgb(vec3((angle/TWO_PI) + 0.5, radius, 1.0));
	
    float shapedHue = uv.x;
    shapedHue = pow(uv.x, 5.0);
    color = hsb2rgb(vec3((angle/TWO_PI) + 0.5, radius, 1.0));
	return vec4(color, 1.0);
}

void fragment() {
	COLOR = HsbToPolarCoords(UV,TIME);
}

