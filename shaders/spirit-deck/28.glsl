#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse; 
uniform float u_time;

#include "./modules/04.glsl"
#include "./modules/08.glsl"
#include "./modules/28.glsl"

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.);

    color += stroke(circleSDF(st), .8, .05);
    st.y = 1.-st.y;
    float s = starSDF(st.yx, 5, .1);
    color *= step(.7, s);
    color += stroke(s, .4, .1);

    gl_FragColor = vec4(color,1.0);
}