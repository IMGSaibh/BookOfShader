shader_type canvas_item;

// YUV to RGB matrix
const mat3 yuv2rgb_matrix = mat3(vec3(1.0, 0.0, 1.13983),
                    vec3(1.0, -0.39465, -0.58060),
                    vec3(1.0, 2.03211, 0.0));

// RGB to YUV matrix
const mat3 rgb2yuv_matrix = mat3(vec3(0.2126, 0.7152, 0.0722),
                    vec3(-0.09991, -0.33609, 0.43600),
                    vec3(0.615, -0.5586, -0.05639) );
					
void fragment() {
    vec3 color = vec3(0.0);
	vec2 uv = UV; 
    // UV values goes from -1 to 1
    // So we need to remap st (0.0 to 1.0)
    uv -= 0.5;  // becomes -0.5 to 0.5
    uv *= 2.0;  // becomes -1.0 to 1.0

    // we pass st as the y & z values of
    // a three dimensional vector to be
    // properly multiply by a 3x3 matrix
    color = yuv2rgb_matrix * vec3(0.5, uv.x, uv.y);
    //color = rgb2yuv_matrix * vec3(0.5, uv.x, uv.y);
	COLOR = vec4(color,1.0);
}

