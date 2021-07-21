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
    vec4 color = vec4(0.);

    float offset = clamp(sin(u_time)/107., 0., .5);
    for (int i = 0; i < 4; i++) {
        color[i] = texture2D(u_texture_1,st + offset * float(i))[i];
    }

    gl_FragColor = color;
}