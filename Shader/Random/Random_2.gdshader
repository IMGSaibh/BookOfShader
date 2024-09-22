shader_type canvas_item;

float random (vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233) ) ) * 43758.5453123);
}

void fragment() {
	vec2 uv = UV;
	uv *= 4.0; // Scale the coordinate system by 10
	vec2 ipos = floor(uv);  // get the integer coords
	vec2 fpos = fract(uv);  // get the fractional coords

	// Assign a random value based on the integer coord
	vec3 color = vec3(random(ipos));

	// Uncomment to see the subdivided grid
	 //color = vec3(fpos,0.0);

	COLOR = vec4(color,1.0);

}

