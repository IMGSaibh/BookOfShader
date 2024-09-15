shader_type canvas_item;

float random_1(in float x) {
    return fract(sin(x) * 1e4);
}

float randomSerie(float x, float freq, float t) {
    return step(0.8, random_1( floor(x * freq) - floor(t) ));
}

void fragment() {

    vec3 color = vec3(0.0);

    float cols = 2.0;
    float freq = random_1(floor(TIME)) + abs(atan(TIME) * 0.1);
    float t = 10.0 + TIME * (1.0 - freq) * 30.0;

    if (fract(UV.y * cols * 0.5) < 0.5){
        t *= -1.0;
    }

    freq += random_1(floor(UV.y));

    float offset = 0.025;
    color = vec3(randomSerie(UV.x, freq * 100.0, t+offset),
                 randomSerie(UV.x, freq * 100.0, t),
                 randomSerie(UV.x, freq * 100.0, t-offset));

    COLOR = vec4(1.0 - color, 1.0);
}

