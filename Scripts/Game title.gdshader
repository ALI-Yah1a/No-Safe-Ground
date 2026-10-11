shader_type canvas_item;

uniform vec4 hot_color : source_color = vec4(1.0, 0.32, 0.08, 1.0);
uniform float intensity : hint_range(0.0, 1.0) = 0.18;
uniform float flicker_speed : hint_range(0.0, 5.0) = 1.5;

void fragment() {
    // Preserve the Label's rendered color and alpha.
    vec4 text_color = COLOR;

    float flicker = 0.5 + 0.5 * sin(TIME * flicker_speed);
    float amount = intensity * (0.65 + flicker * 0.35);

    text_color.rgb = mix(
        text_color.rgb,
        hot_color.rgb,
        amount
    );

    COLOR = text_color;

}
