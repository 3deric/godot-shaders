shader_type canvas_item;
// simple canvas shader for user interfaces, rotates the vertices of the mesh

uniform sampler2D noise_texture : source_color;
uniform float noise_size = 1.0;

void fragment() {
	COLOR = vec4(UV, 0.0, 1.0);
}

void vertex() {
  float offset = texture(noise_texture, UV * noise_size).r;
  VERTEX += vec2(cos(TIME)*20.0 * offset, sin(TIME)*20.0 * offset);
}