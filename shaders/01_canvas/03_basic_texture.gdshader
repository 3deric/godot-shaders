shader_type canvas_item;
// simple texture rendering with scaling and tint
uniform sampler2D color_texture : source_color, repeat_enable;
uniform float size = 1.0;
uniform vec4 tint = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
	 COLOR = texture(color_texture, UV * vec2(size, size)) * tint;
}

