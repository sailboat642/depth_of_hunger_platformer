shader_type canvas_item;

// This allows us to grab the screen texture behind the acid pool
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
    // Get the color of the screen at this specific pixel
    vec4 screen_color = texture(screen_texture, SCREEN_UV);
    
    // Invert the RGB values: (1.0 - current_color)
    // Because it's 1-bit, White (1,1,1) becomes Black (0,0,0) and vice versa.
    vec3 inverted_rgb = vec3(1.0) - screen_color.rgb;
    
    // Output the inverted color with the alpha of the acid shape
    COLOR = vec4(inverted_rgb, texture(TEXTURE, UV).a);
}