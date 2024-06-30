shader_type canvas_item;
const vec3 colorA = vec3(0.149,0.141,0.912);
const vec3 colorB = vec3(1.000,0.833,0.224);
#define TWO_PI 6.28318530718

float circle(float x){
	
	return sqrt(pow(0.5, 2.0)-pow(x,2.0));
} 
float plot (vec2 uv, float pct){
  return  smoothstep( pct-0.01, pct, 1.0-uv.y) -
          smoothstep( pct, pct+0.01, 1.0-uv.y);
}

vec4 colorTime(){
    vec3 color = vec3(0.0);

    float pct = abs(sin(TIME));

    // Mix uses pct (a value from 0-1) to
    // mix the two colors
    color = mix(colorA, colorB, pct);
	return vec4(color, 1.0);
}

vec4 colorGradient(vec2 uv){
    vec3 color = vec3(0.0);

    vec3 pct = vec3(uv.x);

    // pct.r = smoothstep(0.0,1.0, st.x);
    // pct.g = sin(st.x*PI);
    // pct.b = pow(st.x,0.5);

    color = mix(colorA, colorB, pct);

    // Plot transition lines for each channel
    color = mix(color,vec3(1.0,0.0,0.0),plot(uv,pct.r));
    color = mix(color,vec3(0.0,1.0,0.0),plot(uv,pct.g));
    color = mix(color,vec3(0.0,0.0,1.0),plot(uv,pct.b));
	return vec4(color, 1.0);
}

vec4 rainbowFunction(vec2 uv){
	vec3 colorRainbow = vec3(0.0);
    vec3 plotValue = vec3(uv.x);
	
    plotValue.r = 0.51 * sin(uv.x * PI);
    plotValue.g = 0.53 * sin(uv.x * PI);
    plotValue.b = 0.55 * sin(uv.x * PI);
	
    colorRainbow = mix(colorA, colorB, plotValue);
	
    colorRainbow = mix(colorRainbow, vec3(1.0,0.0,0.0),plot(uv, plotValue.r));
    colorRainbow = mix(colorRainbow, vec3(0.0,1.0,0.0),plot(uv, plotValue.g));
    colorRainbow = mix(colorRainbow, vec3(0.0,0.0,1.0),plot(uv, plotValue.b));
	
    return vec4(colorRainbow,1.0);
	
}

vec4 functionsDraw(vec2 uv){
	// Called for every pixel the material is visible on.
	vec3 color = vec3(0.0);

	// float pct = abs(sin(TIME));
	vec3 pct = vec3(uv.x);
	pct.r = smoothstep(0.0,1.0, uv.x);
	//pct.r = sin(UV.x);
	pct.g = sin(uv.x * PI);
	pct.b = pow(uv.x, 0.5);

	// Mix uses pct (a value from 0-1) to
	// mix the two colors
	color = mix(colorA, colorB, pct);

	// Plot transition lines for each channel
	color = mix(color, vec3(1.0,0.0,0.0),plot(uv, pct.r));
	color = mix(color, vec3(0.0,1.0,0.0),plot(uv, pct.g));
	color = mix(color, vec3(0.0,0.0,1.0),plot(uv, pct.b));
	return vec4(color,1.0);
}

void fragment() {
	
	COLOR = functionsDraw(UV);
	//COLOR = colorTime();
	//COLOR = colorGradient(UV);
	COLOR = rainbowFunction(UV);

}








