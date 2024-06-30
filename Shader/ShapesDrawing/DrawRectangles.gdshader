shader_type canvas_item;
uniform float verticalRectThickness : hint_range(0.0, 0.5);


vec3 halfRectangle(vec2 uv){
	vec3 color = vec3(0.0);
    // Each result will return 1.0 (white) or 0.0 (black).
	// The step() function will turn every pixel below 0.1 to black (vec3(0.0)) and the rest to white (vec3(1.0))
	// Similar to ( X greater than 0.1 )
    float left = step(0.1, uv.x); 
    
	// Similar to ( Y greater than 0.1 )
	float top = step(0.1, uv.y);
    //The multiplication of left*bottom will be similar to the logical AND.
    color = vec3( left * top );
	return color;
}
vec3 fullRectangleSimple(vec2 uv){
	vec3 color = vec3(0.0);
	vec2 borders = step(vec2(0.1), uv);
	// rectangle top and left side
	float topLeftBorders = borders.x * borders.y;
	
    //bottom right
    vec2 bottomRightBorders = step(vec2(0.1),1.0 - uv);
    topLeftBorders *= bottomRightBorders.x * bottomRightBorders.y;
    color = vec3(topLeftBorders);
	return color;
}
vec3 fullRectangleProportions(vec2 uv, float thickness){
	vec3 color = vec3(0.0);
	vec2 borders = step(vec2(thickness), uv);
	// rectangle top and left side
	float topLeftBorders = borders.x * borders.y;
	
    //bottom right
    vec2 bottomRightBorders = step(vec2(thickness), 1.0 - uv);
    topLeftBorders *= bottomRightBorders.x * bottomRightBorders.y;
    color = vec3(topLeftBorders);
	return color;
}
vec3 fullRectangleProportionsSmoothstep(vec2 uv, float thickness){
	vec3 color = vec3(0.0);
	vec2 borders = smoothstep(0.1 - thickness, 0.5, uv);
	// rectangle top and left side
	float topLeftBorders = borders.x * borders.y;
	
    //bottom right
    vec2 bottomRightBorders = smoothstep(0.1 - thickness, 0.5, 1.0 - uv);
    topLeftBorders *= bottomRightBorders.x * bottomRightBorders.y;
    color = vec3(topLeftBorders);
	return color;
}
float DrawRectangle(vec2 uv, float verticalThickness, float verticalOffset, float horizontalThickness, float horizontalOffset){
    float left = step(verticalThickness + verticalOffset, uv.x);
    float right = step(verticalThickness - verticalOffset, 1.0 - uv.x);
    float top = step(horizontalThickness + horizontalOffset, uv.y);
    float bottom = step(horizontalThickness - horizontalOffset, 1.0 - uv.y);
    return left * right * top * bottom;
}

void fragment() {
	//vec4 color1 = vec4(0.0);
	//vec4 color2 = vec4(0.0);
	//color1 = vec4(fullRectangleProportions(UV, verticalRectThickness), 1.0);
	//color2 = vec4(fullRectangleProportionsSmoothstep(UV, verticalRectThickness), 1.0);
	//COLOR = color1 * color2;
	
	vec4 color3 = vec4(DrawRectangle(UV, 0.4, -0.4, 0.3, -0.35)) * vec4(1.0, 0.0, 0.0, 1.0);
	vec4 color4 = vec4(DrawRectangle(UV, 0.48, -0.28, 0.0, 0.0)) * vec4(0.0, 0.0, 0.0, 1.0);
	vec4 color5 = vec4(DrawRectangle(UV, 0.48, 0.28, 0.0, 0.0)) * vec4(0.0, 0.0, 0.0, 1.0);
	vec4 color6 = vec4(DrawRectangle(UV, 0.48,  0.45, 0.0, 0.0)) * vec4(0.0, 0.0, 0.0, 1.0);
	vec4 color7 = vec4(DrawRectangle(UV, 0.0, 0.0, 0.48, -0.13)) * vec4(0.0, 0.0, 0.0, 1.0);
	vec4 color8 = vec4(DrawRectangle(UV, 0.4, 0.57, 0.3, -0.35)) * vec4(1.0, 1.0, 0.0, 1.0);
	
	vec4 tempColor = color3 + color4 + color5 + color6 + color7 + color8 * vec4(1.0);
	if (tempColor.a == 0.0){
		tempColor = vec4(0.94, 0.93, 0.8, 1.0);
	}
	COLOR = tempColor;
}

