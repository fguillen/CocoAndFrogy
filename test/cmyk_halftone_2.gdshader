shader_type canvas_item;
render_mode unshaded, blend_disabled;
uniform int dot_amount = 64; 
uniform float noise_amount = 0.3;
uniform float dot_noise_amount = 0.3;
uniform float dot_scale = 1.0;
uniform float gamma = -0.1;
uniform vec3 error_fraction;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_nearest;

float aastep(float threshold, float value) {
  float afwidth = 0.8 * length(vec2(dFdx(value), dFdy(value)));
  return smoothstep(threshold-afwidth, threshold+afwidth, value);
}

// Description : Array- and textureless GLSL 2D simplex noise.
// Author : Ian McEwan, Ashima Arts. Version: 20110822
// Copyright (C) 2011 Ashima Arts. All rights reserved.
// Distributed under the MIT License. See LICENSE file.
// https://github.com/ashima/webgl-noise
 
vec2 vec2mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 vec3mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 permute(vec3 x) { return vec3mod289((( x * 34.0) + 1.0) * x); }
 
float snoise(vec2 v) {
  const vec4 C = vec4(0.211324865405187,  // (3.0-sqrt(3.0))/6.0
                      0.366025403784439,  // 0.5*(sqrt(3.0)-1.0)
                     -0.577350269189626,  // -1.0 + 2.0 * C.x
                      0.024390243902439); // 1.0 / 41.0
  // First corner
  vec2 i = floor(v + dot(v, C.yy) );
  vec2 x0 = v - i + dot(i, C.xx);
  // Other corners
  vec2 i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
  vec4 x12 = x0.xyxy + C.xxzz;
  x12.xy -= i1;
  // Permutations
  i = vec2mod289(i); // Avoid truncation effects in permutation
  vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
                           + i.x + vec3(0.0, i1.x, 1.0 ));
  vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy),
                          dot(x12.zw,x12.zw)), 0.0);
  m = m*m; m = m*m;
  // Gradients
  vec3 x = 2.0 * fract(p * C.www) - 1.0;
  vec3 h = abs(x) - 0.5;
  vec3 a0 = x - floor(x + 0.5);
  // Normalise gradients implicitly by scaling m
  m *= 1.792843 - 0.853735 * ( a0*a0 + h*h );
  // Compute final noise value at P
  vec3 g;
  g.x = a0.x * x0.x + h.x * x0.y;
  g.yz = a0.yz * x12.xz + h.yz * x12.yw;
  return 130.0 * dot(m, g);
}


void fragment() {
	
	// compute fractal noise
	float n = 0.1 * snoise(SCREEN_UV * 200.0);
	n += 0.05 * snoise(SCREEN_UV*400.0);
	n += 0.025 * snoise(SCREEN_UV*800.0);
	
	vec3 black = vec3(n + 0.0025);
	
	// RGB to CMYK
	vec4 cmyk;
	cmyk.x = 1.0 - texture(SCREEN_TEXTURE, SCREEN_UV - error_fraction.x).r;
	cmyk.y = 1.0 - texture(SCREEN_TEXTURE, SCREEN_UV - error_fraction.y).g;
	cmyk.z = 1.0 - texture(SCREEN_TEXTURE, SCREEN_UV - error_fraction.z).b;
	cmyk.w = min(cmyk.x, min(cmyk.y, cmyk.z));
	cmyk.xyz -= cmyk.w;
	
	// dot amount to float
	float frequency = float(dot_amount);
	// ratio
	vec2 ratio = (SCREEN_PIXEL_SIZE.x > SCREEN_PIXEL_SIZE.y) ? vec2(SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x, 1) : vec2(1, SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y);
	// rotate the SCREEN_UV using 2D rotation matrix
	// vec2(cos(f), -sin(f)), vec2(sin(f), cos(f))
	// https://en.wikipedia.org/wiki/Rotation_matrix
	vec2 k_st = frequency * mat2(vec2(0.707, -0.707), vec2(0.707, 0.707)) * (SCREEN_UV * ratio);
	vec2 Kuv = 2.0 * fract(k_st) - 1.0;
	float k = aastep(1.0 - dot_scale, sqrt(cmyk.w) - length(Kuv) + n * dot_noise_amount);
	// 15 degrees
	vec2 c_st = frequency * mat2(vec2(0.966, -0.259), vec2(0.259, 0.966)) * (SCREEN_UV * ratio);
	vec2 Cuv = 2.0 * fract(c_st) - 1.0;
	float c = aastep(1.0 - dot_scale, sqrt(cmyk.x) - length(Cuv) + n * dot_noise_amount);
	// -15 degrees
	vec2 m_st = frequency * mat2(vec2(0.966, 0.259), vec2(-0.259, 0.966)) * (SCREEN_UV * ratio);
	vec2 Muv = 2.0 * fract(m_st) - 1.0;
	float m = aastep(1.0 - dot_scale, sqrt(cmyk.y) - length(Muv) + n * dot_noise_amount);
	// 0 degrees
	vec2 y_st = frequency * (SCREEN_UV * ratio);
	vec2 Yuv = 2.0 * fract(y_st) - 1.0;
	float y = aastep(1.0 - dot_scale, sqrt(cmyk.z) - length(Yuv) + n * dot_noise_amount);
	// CMY to RGB + noise
	vec3 rgbscreen = 1.0 - (vec3(c,m,y) - gamma) * (1.0 - noise_amount) + noise_amount * n;
	rgbscreen = mix(rgbscreen, black, (1.0 - noise_amount) * k + noise_amount * n);
	COLOR = vec4(rgbscreen, 1.0);
}