#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse; 
uniform float u_time;

#include "./modules/09.glsl"
#include "./modules/26.glsl"

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.);

    float d1 = polySDF(st, 5);
    vec2 ts = vec2(st.x, 1.-st.y);
    float d2 = polySDF(ts, 5);
    color += fill(d1, .75) * 
        fill(fract(d1*5.), .5);
    color -= fill(d1, .6) *
        fill(fract(d2*4.9), .45);

    gl_FragColor = vec4(color,1.0);
}