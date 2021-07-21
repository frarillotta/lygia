#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse; 
uniform float u_time;

#include "./modules/09.glsl"
#include "./modules/15.glsl"
#include "./modules/19.glsl"

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.);

    st = rotate(st, radians(-25.));
    float sdf = triSDF(st);
    sdf /= triSDF(st+vec2(0., .2));
    color += fill(abs(sdf), .56);

    gl_FragColor = vec4(color,1.0);
}