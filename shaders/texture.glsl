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

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st = ratio(st, u_resolution);
    vec4 color = vec4(st.x,st.y,0.0,1.0);


    float grid = u_resolution.x/5.5;
    vec2 st_f = fract(st);
    vec2 st_i = floor(st * grid)/grid;
    // st_i = st;
    
    // color = vec4(st.x,st.y,abs(sin(u_time)), 1.);
    color = texture2D(u_texture_1,st_i);
    color = vec4(dither8x8(gl_FragCoord.xy, color));


    gl_FragColor = color;
}