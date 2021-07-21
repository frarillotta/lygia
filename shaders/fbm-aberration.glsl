// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse; 
uniform float u_time;


#include "../space/ratio.glsl"
#include "../generative/fbm.glsl"
#include "../sdf/flowerSDF.glsl"
#include "../color/space/hsv2rgb.glsl"
#include "../generative/snoise.glsl"
#include "../generative/pnoise.glsl"

float getNoise(vec2 st) {

    float noise = fbm(vec3(st, u_time/6.));
    float noise2 = fbm(vec3(noise));
    float noise3 = fbm(vec3(noise2, noise, noise));
    float noise4 = fbm(vec3(noise3, noise2, .7));

    return noise4;

}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st = ratio(st, u_resolution);

    float grid = u_resolution.x/18.;
    vec2 st_f = fract(st);
    vec2 st_i = floor(st * grid)/grid;
    

    // st_i = st;
    float n = 0.4 + snoise(vec3(st_i, u_time)) * 0.8;
    float p = .5 + pnoise(vec3(st_i, u_time), vec3(n)) * 0.8;

    vec3 color = vec3(0.);
    // color += hsv2rgb(vec3(n * .41, 1., 1.));

    color = vec3(st.x,st.y, 1.);

    float offset = .01;
    for (int i = 0; i < 3; i++) {
        color[i] += getNoise(st + offset * float(i));
    }
    gl_FragColor = vec4(color,1.0);
}

