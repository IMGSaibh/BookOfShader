shader_type canvas_item;

float random (in vec2 _uv) {
    return fract(sin(dot(_uv.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

vec2 truchetPattern(in vec2 _uv, in float _index){
    _index = fract(((_index-0.5)*2.0));
    if (_index > 0.75) {
        _uv = vec2(1.0) - _uv;
    } else if (_index > 0.5) {
        _uv = vec2(1.0-_uv.x,_uv.y);
    } else if (_index > 0.25) {
        _uv = 1.0-vec2(1.0 - _uv.x, _uv.y);
    }
    return _uv;
}

void fragment() {
    vec2 uv = UV;
    uv *= 10.0;
	uv = (uv - vec2(5.0)) * (abs(sin(TIME * 0.2)) * 5.0);
	uv.x += TIME * 3.0;

    vec2 ipos = floor(uv);  // integer
    vec2 fpos = fract(uv);  // fraction

    vec2 tile = truchetPattern(fpos, random( ipos ));

    float color = 0.0;
    // Maze
    color = smoothstep(tile.x - 0.3, tile.x, tile.y)-
            smoothstep(tile.x, tile.x + 0.3, tile.y);
			
    // Circles
    color = step(length(tile),0.6) - step(length(tile),0.4) +
            step(length(tile - vec2(1.)),0.6) - step(length(tile - vec2(1.)),0.4);
			
    // Truchet (2 triangles)
     //color = step(tile.x,tile.y);
			
    COLOR = vec4(vec3(color),1.0);

}

