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

    float n = 0.4 + snoise(vec3(st, .5)) * 0.8;
 
    float noise = fbm(vec3( n*15., st));
    float noise2 = fbm(vec3(st, noise));
    float noise3 = fbm(vec3(st, noise2+u_time));
    float noise4 = fbm(vec3(noise+u_time, noise2/u_time, noise3*u_time));
    float noise5 = fbm(vec3(st, noise4));
    vec3 color = vec3(noise4, noise3, noise5);

    gl_FragColor = vec4(color,1.0);
} 