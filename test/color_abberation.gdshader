// from here: https://godotshaders.com/shader/chromatic-abberation/

shader_type canvas_item;

uniform int levels : hint_range(0, 9) = 3;
uniform float spread : hint_range(0.0, 1.0) = 0.01;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

vec3 chromatic_slice(float t){
	vec3 res = vec3(1.0-t, 1.0 - abs(t - 1.0), t - 1.0);
	return max(res, 0.0);
}

void fragment(){
	vec3 sum;
	COLOR.rgb = vec3(0);
	vec2 offset = (SCREEN_UV - vec2(0.5))*vec2(1,-1);
	for(int i = 0; i < levels; i++){
		float t = 2.0*float(i)/float(levels-1); // range 0.0->2.0
		vec3 slice = vec3(1.0-t, 1.0 - abs(t - 1.0), t - 1.0);
		slice = max(slice, 0.0);
		sum += slice;
		vec2 slice_offset = (t-1.0)*spread*offset;
		COLOR.rgb += slice * textureLod(screen_texture, SCREEN_UV + slice_offset, 0.0).rgb;
	}
	COLOR.rgb /= sum;
}