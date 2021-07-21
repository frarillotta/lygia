#ifdef GL_ES 
precision mediump float;
#endif


uniform vec2 u_resolution;
uniform vec2 u_mouse; 
uniform float u_time;

#include "./modules/04.glsl"
#include "./modules/09.glsl"
#include "./modules/10.glsl"
#include "./modules/12.glsl"
#include "./modules/30.glsl"
#include "../../space/ratio.glsl"

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st = ratio(st, u_resolution);
    vec3 color = vec3(0.);

    color += flip(stroke(raysSDF(st, 28)
        ,.5,.2),
        fill(st.y, .5));
    float rect = rectSDF(st, vec2(1.));
    color *= step(.25, rect);
    color += fill(rect, .2);

    gl_FragColor = vec4(color,1.0);
}