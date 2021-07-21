#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse; 
uniform float u_time;

#include "./modules/09.glsl"
#include "./modules/15.glsl"

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.);

    st.y = 1.-st.y;
    vec2 ts = vec2(st.x, .82-st.y);
    color += fill(triSDF(st), .7);
    color -= fill(triSDF(ts), .36);
    gl_FragColor = vec4(color,1.0);
}