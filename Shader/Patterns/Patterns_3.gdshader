shader_type canvas_item;

vec2 brickTile(vec2 uv, float _zoom){
    uv *= _zoom;

    // Here is where the offset is happening
    uv.x += step(1.0, mod(uv.y, 2.0)) * 0.5;

    return fract(uv);
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
    // st /= vec2(2.15,0.65)/1.5;

    // Apply the brick tiling
    uv = brickTile(uv, 5.0);

    color = vec3(box(uv, vec2(0.9)));

    // Uncomment to see the space coordinates
    // color = vec3(st,0.0);

    COLOR = vec4(color,1.0);
}

