// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#include "../sdf/circleSDF.glsl"
#include "../sdf/flowerSDF.glsl"
#include "../space/ratio.glsl"
#include "../color/space/hsv2rgb.glsl"
#include "../generative/snoise.glsl"
#include "../generative/pnoise.glsl"
#include "../draw/stroke.glsl"
#include "../draw/fill.glsl"

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st = ratio(st, u_resolution);
    vec3 color = vec3(0.);

    float grid = u_resolution.x/75.;
    vec2 st_i = floor(st * grid)/grid; 
    // st_i = st;

    vec2 st_f = fract(st * grid); 
    // color += stroke(st.x, .5, .1);

    float n = 0.4 + snoise(vec3(st_i, u_time/4.)) * 0.8;
    float p = .5 + pnoise(vec3(st_i, u_time/4.), vec3(n)) * 0.8;

    // n = clamp(n, .1, .2);

    float sdf = circleSDF(st, vec2(.5));
    float outerSDF = circleSDF(st_f, vec2(.5, .5));
    
    // color += hsv2rgb(vec3(n * .41, 1., 1.));
    color = vec3(n * .41, n * .6, 1.);
    color += stroke(floor(st.x * grid)/grid, .0, .05);

    // color += fill(sdf, .5, .1);
    
    // color += stroke(outerSDF, .7, .1);

    gl_FragColor = vec4(color,1.0);
}
