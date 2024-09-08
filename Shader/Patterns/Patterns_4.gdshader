shader_type canvas_item;
uniform int zoom : hint_range(0, 10);

vec2 rotate2D (vec2 uv, float _angle) {
    uv -= 0.5;
    uv =  mat2(vec2(cos(_angle), -sin(_angle)),
                vec2(sin(_angle), cos(_angle))) * uv;
	uv += 0.5;
    return uv;
}

vec2 tile (vec2 uv, int _zoom) {
    uv *= float(_zoom);
	uv = fract(uv);
    return uv;
}

float myTile(vec2 uv, int _zoom)
{
	float pattern = step(0.9, uv.x); 
	pattern += step(0.9, uv.y);
	pattern += step(0.8, uv.x);
	return pattern;
}


vec2 rotateTilePattern(vec2 uv){

    //  Scale the coordinate system by 2x2
    uv *= 2.0;

    //  Give each cell an index number
    //  according to its position
    float index = 0.0;
    index += step(1.0, mod(uv.x, 2.0));
    index += step(1.0, mod(uv.y, 2.0)) * 2.0;

    //      |
    //  2   |   3
    //      |
    //--------------
    //      |
    //  0   |   1
    //      |

    // Make each cell between 0.0 - 1.0
    uv = fract(uv);

    // Rotate each cell according to the index
    if(index == 1.0){
        //  Rotate cell 1 by 90 degrees
        uv = rotate2D(uv, PI * 0.5);
    } else if(index == 2.0){
        //  Rotate cell 2 by -90 degrees
        uv = rotate2D(uv, PI * -0.5);
    } else if(index == 3.0){
        //  Rotate cell 3 by 180 degrees
        uv = rotate2D(uv, PI);
    }

    return uv;
}
void fragment() {
	vec2 uv = UV;
    uv = tile(uv, zoom);
	
    uv = rotateTilePattern(uv);

	// Make more interesting combinations
	//uv = tile(uv, zoom);
	//uv = rotate2D(uv, -PI * TIME * 0.25);
	uv = rotateTilePattern(uv * 2.0);
	uv = rotate2D(uv, PI * TIME * 0.25);
	

	 //just makes a b&w triangles
	step(uv.x,uv.y); 
	// but you can use whatever design you want.
	COLOR = vec4(vec3(step(uv.x,uv.y)), 1.0);
	
	//COLOR = vec4(vec3(myTile(uv, zoom)), 1.0);
}

