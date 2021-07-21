#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../space/ratio.glsl"
#include "../generative/fbm.glsl"

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st = ratio(st, u_resolution);

    float n = 0.4 + snoise(vec3(st, u_time)) * 0.8;

    float noise = fbm(vec3(st, u_time/10.));
    float noise2 = fbm(vec3(st, noise));
    float noise3 = fbm(vec3(st, noise2));
    float noise4 = fbm(vec3(st, noise3));

    vec3 color = vec3(st.x,st.y, 1.);

    color += noise4;

    gl_FragColor = vec4(color,1.0);
}