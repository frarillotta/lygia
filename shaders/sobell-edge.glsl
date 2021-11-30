// Author:
// Title:

precision mediump float;

uniform vec2 u_resolution;
uniform vec2 u_mouse; 
uniform float u_time;

uniform sampler2D u_texture_1;
uniform vec2 u_texture_1_Resolution;

#include "../filter/dither/dither8x8.glsl"
#include "../space/ratio.glsl"

vec4 make_kernel(sampler2D tex, vec2 coord)
{
	vec4 n[9];
	float w = 1.0 / u_resolution.x;
	float h = 1.0 / u_resolution.y;

	n[0] = texture2D(tex, coord + vec2( -w, -h));
	n[1] = texture2D(tex, coord + vec2(0.0, -h));
	n[2] = texture2D(tex, coord + vec2(  w, -h));
	n[3] = texture2D(tex, coord + vec2( -w, 0.0));
	n[4] = texture2D(tex, coord);
	n[5] = texture2D(tex, coord + vec2(  w, 0.0));
	n[6] = texture2D(tex, coord + vec2( -w, h));
	n[7] = texture2D(tex, coord + vec2(0.0, h));
	n[8] = texture2D(tex, coord + vec2(  w, h));
	
	vec4 sobel_edge_h = n[2] + (2.0*n[5]) + n[8] - (n[0] + (2.0*n[3]) + n[6]);
  	vec4 sobel_edge_v = n[0] + (2.0*n[1]) + n[2] - (n[6] + (2.0*n[7]) + n[8]);
	vec4 sobel = sqrt((sobel_edge_h * sobel_edge_h) + (sobel_edge_v * sobel_edge_v));
    
	return sobel;
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st = ratio(st, u_resolution);
    vec4 color = vec4(st.x,st.y,0.0,1.0);

	vec4 sobel = make_kernel( u_texture_1, st );
	
	float grid = u_resolution.x/5.5;
    vec2 st_f = fract(st);
    vec2 st_i = floor(st * grid)/grid;
    // st_i = st;
    
    // color = vec4(st.x,st.y,abs(sin(u_time)), 1.);
    color = texture2D(u_texture_1,st_i);
    color = vec4(dither8x8(gl_FragCoord.xy, color));

    gl_FragColor = vec4( 1.0 - sobel.rgb, 1.0 );
}