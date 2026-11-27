shader_type canvas_item;

uniform sampler2D noise_texture : hint_normal, repeat_enable;
uniform float dist_threshold : hint_range(0, 128)  = 32;
uniform float texture_size   : hint_range(0, 1024) = 1024;

void fragment() {
	vec2 uv_deriv = fwidth(UV);
	vec2 corrected_uv = UV / uv_deriv;
	vec2 tiled_uv = SCREEN_UV / (SCREEN_PIXEL_SIZE * texture_size);
	// calculate the edge distance
	float edge_dist = min(
	    min(corrected_uv.x, (1.0 - UV.x) / uv_deriv.x),
	    min(corrected_uv.y, (1.0 - UV.y) / uv_deriv.y)
	);
	// sample the noise
	float noise = texture(noise_texture,tiled_uv).r;
	float side_noise = texture(noise_texture,tiled_uv * vec2(0.1,1)).g;
	// divide the edge distance by the distance theshold 
	// to not affect the inner part, works without clamping too
	float edge = clamp(edge_dist / dist_threshold, 0.0, 1.0);

	// roughen up the edges with the noise
	float rough_edge = edge + (noise - 0.5) * 0.5;
	// cutoff the alpha based on a fixed treshold value (0.5)
	float alpha_value = rough_edge > 0.5 ? 1.0 : 0.0;

	COLOR = vec4(alpha_value,0.0, 0.0, 1.0);
}