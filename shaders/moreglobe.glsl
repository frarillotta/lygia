
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

    float grid = 25.;
    vec2 st_i = floor(st*grid)/grid; 
    
    st_i = st; 

    vec2 st_f = fract(st * grid); 

    float sdf = circleSDF(st, vec2(.5));
    float outerSDF = circleSDF(st_f, vec2(.5, .5));

    float n = 0.4 + snoise(vec3(vec2(st_i), u_time)) * 0.8;
    float p = .5 + pnoise(vec3(vec2(st_i), u_time), vec3(n, .5, n)) * 0.8;

    float circle = fill(sdf, .8, .002);

    circle *= .5;


    
    // color += hsv2rgb(vec3(n, 1., 1.));
    // color += circle;

    color = mix(vec3(0.), hsv2rgb(vec3(n, 1., 1.5)), circle);
    
    // color += stroke(outerSDF, .7, .1);

    gl_FragColor = vec4(color,1.0);
}