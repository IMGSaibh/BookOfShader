shader_type canvas_item;
#define TWO_PI 6.28318530718
uniform float time_sim : hint_range(0.0, TWO_PI);

vec2 brickTile(vec2 uv, float _zoom){
    uv *= _zoom;

    // Here is where the offset is happening
    //uv.x += step(1.0, mod(uv.y, 2.0)) * 0.5 * TIME;
	
	
	// excersise 2
    //uv.x -= step(mod(uv.y, 2.0), 1.0) * 0.5 * TIME;

	// excersise 3
	//uv.y += step(1.0, mod(uv.x, 2.0)) * 0.5 * TIME;
	//uv.y -= step(mod(uv.x, 2.0), 1.0) * 0.5 * TIME;
	
	
	// excersise 4
	float normalizedLinear = sin(TIME * 5.0); 
	if(normalizedLinear > 0.0)
	{
		uv.y += step(1.0, mod(uv.x, 2.0)) * 0.5 * TIME;
		uv.y -= step(mod(uv.x, 2.0), 1.0) * 0.5 * TIME;
	}
	else
	{
    	uv.x += step(1.0, mod(uv.y, 2.0)) * 0.5 * TIME;
	    uv.x -= step(mod(uv.y, 2.0), 1.0) * 0.5 * TIME;
	}
	
	uv = fract(uv);
    return uv;
}

float box(vec2 uv, vec2 _size){
    _size = vec2(0.5)-_size*0.5;
    vec2 uv_local = smoothstep(_size, _size + vec2(1e-4), uv);
    uv_local *= smoothstep(_size, _size + vec2(1e-4), vec2(1.0) - uv);
    return uv_local.x * uv_local.y;
}

void fragment() {
    vec3 color = vec3(0.0);
	vec2 uv = UV;
    // Modern metric brick of 215mm x 102.5mm x 65mm
    // http://www.jaharrison.me.uk/Brickwork/Sizes.html
    
	//uv /= vec2(2.15,0.65)/1.5;

    // Apply the brick tiling
    uv = brickTile(uv, 5.0);

    color = vec3(box(uv, vec2(0.9)));

    // Uncomment to see the space coordinates
     //color = vec3(uv, 0.0);

    COLOR = vec4(color,1.0);
}

