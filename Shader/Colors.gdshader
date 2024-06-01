shader_type canvas_item;
const vec3 colorA = vec3(0.149,0.141,0.912);
const vec3 colorB = vec3(1.000,0.833,0.224);

float circle(float x){
	
	return sqrt(pow(0.5, 2.0)-pow(x,2.0));
} 
float plot (vec2 uv, float pct){
  return  smoothstep( pct-0.01, pct, 1.0-uv.y) -
          smoothstep( pct, pct+0.01, 1.0-uv.y);
}

void fragment() {
	//// Called for every pixel the material is visible on.
	//vec3 color = vec3(0.0);
//
    ////float pct = abs(sin(TIME));
    //vec3 pct = vec3(UV.x);
     //pct.r = smoothstep(0.0,1.0, UV.x);
     ////pct.r = sin(UV.x);
     //pct.g = sin(UV.x * PI);
     //pct.b = pow(UV.x, 0.5);
//
    //// Mix uses pct (a value from 0-1) to
    //// mix the two colors
    //color = mix(colorA, colorB, pct);
	//
    //// Plot transition lines for each channel
    //color = mix(color, vec3(1.0,0.0,0.0),plot(UV,pct.r));
    //color = mix(color, vec3(0.0,1.0,0.0),plot(UV,pct.g));
    //color = mix(color, vec3(0.0,0.0,1.0),plot(UV,pct.b));
    //COLOR = vec4(color,1.0);
	
	
	/*
	===========================================================
							rainbow
	===========================================================
	*/
	//vec3 colorRainbow = vec3(0.0);
    //vec3 plotValue = vec3(UV.x);
	//
    //plotValue.r = 0.51 * sin(UV.x * PI);
    //plotValue.g = 0.53 * sin(UV.x * PI);
    //plotValue.b = 0.55 * sin(UV.x * PI);
	//
    //colorRainbow = mix(colorA, colorB, plotValue);
	//
    //colorRainbow = mix(colorRainbow, vec3(1.0,0.0,0.0),plot(UV,plotValue.r));
    //colorRainbow = mix(colorRainbow, vec3(0.0,1.0,0.0),plot(UV,plotValue.g));
    //colorRainbow = mix(colorRainbow, vec3(0.0,0.0,1.0),plot(UV,plotValue.b));
	//
    //COLOR = vec4(colorRainbow,1.0);
	
	
	/*
	===========================================================
							flag
	===========================================================
	*/
	
	vec3 colorFlag = vec3(0.0);
    vec3 plotValueFlag = vec3(UV.x);
	
    plotValueFlag.r = step(UV.y, 0.3);
    plotValueFlag.b = step(UV.x, 0.2);
	
	vec3 colorFlag_1 = vec3(step(UV.y, 0.3),step(UV.x, 0.2), 0.0);
	vec3 colorFlag_2 = vec3(0.0, 0.0, 1.0);
	
    //colorFlag = mix(colorFlag_1, colorFlag_2, plotValueFlag);
    //colorFlag = mix(colorFlag, vec3(1.0,0.0,0.0),plot(UV, plotValueFlag.r));
    //colorFlag = mix(colorFlag, vec3(0.0,0.0,1.0),plot(UV, plotValueFlag.b));
	
    COLOR = vec4(colorFlag_1,1.0);
	
}








