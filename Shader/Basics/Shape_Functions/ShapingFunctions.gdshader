shader_type canvas_item;

float plot(vec2 st, float pct){
  return  smoothstep( pct-0.02, pct, 1.0-st.y) -
          smoothstep( pct, pct+0.02, 1.0-st.y);
}

float example_1(float x, float t)
{
	return 0.5 *smoothstep(0,0.7,sin(x+t));
}

// shaping function of Iñigo Quiles
//https://iquilezles.org/articles/functions/
float gain( float x, float k ) 
{
    float a = 0.5*pow(2.0*((x<0.5)?x:1.0-x), k);
    return (x < 0.5) ? a : 1.0 - a;
}

//  Function from Iñigo Quiles
//  www.iquilezles.org/www/articles/functions/functions.htm
float impulse( float k, float x ){
    float h = k*x;
    return h*exp(1.0-h);
}

//  Function from Iñigo Quiles
//  www.iquilezles.org/www/articles/functions/functions.htm
float pcurve( float x, float a, float b ){
    float k = pow(a+b,a+b) / (pow(a,a)*pow(b,b));
    return k * pow( x, a ) * pow( 1.0-x, b );
}

float circle(float x){
	
	return sqrt(pow(0.5, 2.0) - pow(x,2.0));
}

void fragment() {
	// Called for every pixel the material is visible on.
	//float y = pow(UV.x,5.0);

    // Step will return 0.0 unless the value is over 0.5,
    // in that case it will return 1.0
    //float y = step(0.5,UV.x);
	
	/*
	===========================================================
							exercises
	===========================================================
	*/
	float y = sin(TIME+UV.x);
	y = 0.5 * sin(2.0 * TIME + (UV.x*PI)) + 0.5;
	y = 0.5 * tan(TIME + UV.x * 2.0) + 0.5;
	y = 0.3 * atan(UV.x * 2.0) + 0.5;
	//y = sin((UV.x*TIME));
	//y = sin((UV.x * 15.0));
	//y = abs(sin(UV.x*12.0));
	//y = fract(sin(UV.x*12.0));
	//
    // Smooth interpolation between 0.1 and 0.9
    //float y = smoothstep(0.0,1.0, UV.x);
	//float y = smoothstep(0.39,0.4,UV.x) - smoothstep(0.49,0.5,UV.x);
	
	//float y = mod(UV.x,0.5); // return x modulo of 0.5
	//float y = fract(0.4); // return only the fraction part of a number
	//float y = ceil(0.1);  // nearest integer that is greater than or equal to x
	//float y = floor(0.6); // nearest integer that less than or equal to x
	//float y = sign(0.0);  // extract the sign of x
	//float y = abs(UV.x);   // return the absolute value of x
	//float y = clamp(UV.x,0.0,0.6); // constrain x to lie between 0.0 and 0.6
	//float y = min(0.8,UV.x);   // return the lesser of x and 0.0
	//float y = max(0.4,UV.x);   // return the greater of x and 0.0
	
    //float y = impulse(12.,UV.x);
    //float y = pcurve(UV.x,3.0,1.0);
    //float y = gain(UV.x,0.3);
   	y = circle(UV.x-0.5);

    vec3 color = vec3(y);
    float pct = plot(UV,y);
    color = (1.0-pct) * color + pct * vec3(0.0,1.0,0.0);

    COLOR = vec4(color ,1.0);
}
