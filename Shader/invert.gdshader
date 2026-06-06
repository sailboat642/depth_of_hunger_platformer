// BackBufferCopy is supposed to make texture accessible as variables
shader_type canvas_item;
//render_mode unshaded;

void vertex() {
	// Called for every vertex the material is visible on.
}

// This matches exactly what Godot 4 expects for the screen texture uniform
uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

void fragment() {
	vec4 c = textureLod(screen_texture, SCREEN_UV, 0.0);
	COLOR = vec4(1.0 - c.rgb, c.a);
}