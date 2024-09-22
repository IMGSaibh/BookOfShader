shader_type canvas_item;

vec2 skew (vec2 uv) {
    vec2 r = vec2(0.0);
    r.x = 1.1547 * uv.x;
    r.y = uv.y + 0.5 * r.x;
    return r;
}

vec3 simplexGrid (vec2 uv) {
    vec3 xyz = vec3(0.0);

    vec2 p = fract(skew(uv));
    if (p.x > p.y) {
        xyz.xy = 1.0 - vec2(p.x, p.y - p.x);
        xyz.z = p.y;
    } else {
        xyz.yz = 1.0 - vec2(p.x - p.y, p.y);
        xyz.x = p.x;
    }

    return fract(xyz);
}

void fragment() {
    vec3 color = vec3(0.0);

    // Scale the space to see the grid
    vec2 uv = UV;
	uv *= 4.0;

    // Show the 2D grid
    color.rg = fract(uv);

    // Skew the 2D grid
     color.rg = fract(skew(uv));

    // Subdivide the grid into to equilateral triangles
     color = simplexGrid(uv);

    COLOR = vec4(color,1.0);
}


