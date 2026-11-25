shader_type canvas_item;

uniform sampler2D noise_texture : source_color;
uniform float dist_threshold = 0.5;

void fragment() {
	// calculate the edge distance
	// to do, make it work with different aspect ratios
	float edge_dist = min(
		min(UV.x, 1.0 - UV.x),
        min(UV.y, 1.0 - UV.y)
    );
	// sample the noise
	float noise = texture(noise_texture, UV).r;
	// divide the edge distance by the distance theshold 
	// to not affect the inner part, works without clamping too
	float edge = clamp(edge_dist / dist_threshold, 0.0, 1.0);

	// roughen up the edges with the noise
	float rough_edge = edge + (noise - 0.5) * 0.5;
	// cutoff the alpha based on a fixed treshold value (0.5)
	float alpha_value = rough_edge > 0.5 ? 1.0 : 0.0;

	COLOR = vec4(alpha_value,0.0, 0.0, 1.0);
}