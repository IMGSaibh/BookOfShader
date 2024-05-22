shader_type canvas_item;
const vec3 colorA = vec3(0.149,0.141,0.912);
const vec3 colorB = vec3(1.000,0.833,0.224);
float circle(float x){
	
	return sqrt(pow(0.5, 2.0)-pow(x,2.0));
} 
float plot (vec2 st, float pct){
  return  smoothstep( pct-0.01, pct, 1.0-st.y) -
          smoothstep( pct, pct+0.01, 1.0-st.y);
}
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec3 color = vec3(0.0);

    //float pct = abs(sin(TIME));
    vec3 pct = vec3(UV.x);
     pct.r = smoothstep(0.0,1.0, UV.x);
     pct.g = sin(UV.x * PI);
     pct.b = pow(UV.x, 0.5);


	
    // Mix uses pct (a value from 0-1) to
    // mix the two colors
    color = mix(colorA, colorB, pct);
	
    // Plot transition lines for each channel
    color = mix(color, vec3(1.0,0.0,0.0),plot(UV,pct.r));
    color = mix(color, vec3(0.0,1.0,0.0),plot(UV,pct.g));
    color = mix(color, vec3(0.0,0.0,1.0),plot(UV,pct.b));
    COLOR = vec4(color,1.0);
}
