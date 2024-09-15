shader_type canvas_item;
uniform float constvalue_1 : hint_range(0.0, 100.0);
uniform float constvalue_2 : hint_range(0.0, 100.0);
uniform float constvalue_3 : hint_range(1.0, 50000.0);

float random (vec2 st) {
    //return fract(sin( dot(st.xy, vec2(12.9898, 78.233) ) ) * 43758.5453123);
    return fract(sin( dot(st.xy, vec2(constvalue_1, constvalue_2) ) ) * constvalue_3);
}
void fragment() {

    float rnd = random( UV );
    COLOR = vec4(vec3(rnd),1.0);
}

