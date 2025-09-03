shader_type canvas_item;

uniform vec4 lightning_color : source_color;

uniform float size : hint_range(0.0, 1.0);
uniform float width : hint_range(0.0, 1.0);
uniform float speed;
uniform float cycle;
uniform float ratio;
uniform float time_shift;

float rand(float x){
    return fract(sin(x)*100000.0);
}

void fragment(){
    float bolt = abs(mod(UV.y * cycle + (rand(TIME) + time_shift) * speed * -1.0, 0.5) - 0.25) - 0.125;
    bolt *= 4.0 * width;             // 4 because of the 0.5 period; see your comment
    bolt *= (0.5 - abs(UV.y - 0.5)) * 2.0; // taper at start & end

    float wave = abs(UV.x - 0.5 + bolt);   // center-aligned line
    wave = 1.0 - step(size * 0.5, wave);   // thickness via 'size'

    float blink = step(rand(TIME) * ratio, 0.5);
    wave *= blink;

    vec4 display = lightning_color * vec4(wave);
    COLOR = display;
}
