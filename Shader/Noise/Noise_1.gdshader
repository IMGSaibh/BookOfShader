shader_type canvas_item;
const float TWO_PI = 6.28318530718;

float random_1D (in float x) {
   return fract(sin(x)*1e4);
}
float random_2D (vec2 uv) {
    return fract(sin(dot(uv.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

vec2 rotate(vec2 uv, vec2 pivot, float angle)
{	
	mat2 rotation = mat2(vec2(sin(angle), -cos(angle)),
						vec2(cos(angle), sin(angle)));
	
	uv -= pivot;
	uv = uv * rotation;
	uv += pivot;
	return uv;
}

vec4 polygon(vec2 uv, float width, int sides)
{
	uv = uv * 2.0 - 1.0;
	float angle = atan(uv.x, uv.y);
	float radius = TWO_PI / float(sides);
	
	float dist = cos(floor(0.5 + angle / radius) * radius - angle) * length(uv);
	float poly = step(width, dist);
	return vec4(vec3(poly), 1.0);
}



void fragment() {
	vec2 uv = UV;

	float i = floor(uv.x);  // ganzzahliger Teil
	float f = fract(uv.x);  // Nachkommateil
	float y = random_2D(vec2(i, f));
 	y = mix(random_1D(i), random_1D(i + 1.0), f);
	y = mix(random_1D(i), random_1D(i + 1.0), smoothstep(0.0, 1.0, f));
	
	//uv = rotate(uv, vec2(0.7), TIME);
	// Translate
	uv = uv + vec2(cos( TIME + y), sin(TIME + y)) * 0.2;
	COLOR = polygon(uv, 0.2, 3);

}

