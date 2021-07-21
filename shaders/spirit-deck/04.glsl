#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse; 
uniform float u_time;

#include "./modules/04.glsl"

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.);

    color += stroke(st.x, .5, .15);

    gl_FragColor = vec4(color,1.0);
}