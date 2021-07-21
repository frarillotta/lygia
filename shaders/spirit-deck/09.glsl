#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse; 
uniform float u_time;

#include "./modules/08.glsl"
#include "./modules/09.glsl"

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.);

    color += fill(circleSDF(st), .65);
    vec2 offset = vec2(.1, .05);
    color -= fill(circleSDF(st-offset), .5);

    gl_FragColor = vec4(color,1.0);
}