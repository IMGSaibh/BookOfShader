shader_type canvas_item;

float plot(vec2 st, float pct){
  return  smoothstep( pct-0.02, pct, 1.0-st.y) -
          smoothstep( pct, pct+0.02, 1.0-st.y);
}
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	//float y = pow(UV.x,5.0);

    // Step will return 0.0 unless the value is over 0.5,
    // in that case it will return 1.0
    //float y = step(0.5,UV.x);
	
    // Smooth interpolation between 0.1 and 0.9
    float y = smoothstep(0.1,0.9, UV.x);
	//float y = smoothstep(0.2,0.5,UV.x) - smoothstep(0.5,0.8,UV.x);
	
	//float y = mod(UV.x,0.5); // return x modulo of 0.5
	//float y = fract(0.4); // return only the fraction part of a number
	//float y = ceil(0.7);  // nearest integer that is greater than or equal to x
	//float y = floor(1.0); // nearest integer less than or equal to x
	//float y = sign(0.0);  // extract the sign of x
	//float y = abs(UV.x);   // return the absolute value of x
	//float y = clamp(UV.x,0.0,1.0); // constrain x to lie between 0.0 and 1.0
	//float y = min(0.0,UV.x);   // return the lesser of x and 0.0
	//float y = max(0.0,UV.x);   // return the greater of x and 0.0 
	
    vec3 color = vec3(y);
    float pct = plot(UV,y);
    color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0);

    COLOR = vec4(color,1.0);
}
