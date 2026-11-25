shader_type canvas_item;
// simple canvas shader for user interfaces, ^displays the uv as the material colour

void fragment() {
	COLOR = vec4(UV, 0.0, 1.0);
}