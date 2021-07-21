#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse; 
uniform float u_time;

#include "../space/ratio.glsl"

float random (in vec2 _st) {
    return fract(sin(dot(_st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

float noise (in vec2 _st) {
    vec2 i = floor(_st);
    vec2 f = fract(_st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

#define NUM_OCTAVES 5

float fbm ( in vec2 _st) {
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(100.0);
    // Rotate to reduce axial bias
    mat2 rot = mat2(cos(0.5), sin(0.5),
                    -sin(0.5), cos(0.50));
    for (int i = 0; i < NUM_OCTAVES; ++i) {
        v += a * noise(_st);
        _st = rot * _st * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st = ratio(st, u_resolution);

    float noise = fbm(st);
    noise = fbm(vec2(noise));

    vec3 color = vec3(0.);
    vec2 q = vec2(0.);

    q.x = fbm( st + vec2(0.0,0.0) + .05*u_time );
    q.y = fbm( st + vec2(5.2,1.3) - .08*u_time);
    vec2 r = vec2(0.);

    r.x = fbm( st + 4.0*q + vec2(1.7,9.2) + .08*u_time );
    r.y = fbm( st + 4.0*q + vec2(8.3,2.8) - .05*u_time );
    
    vec2 f = vec2(0.);
    f.x = fbm( st + 5.0*r + vec2(1.2, 5.2) + .05*u_time );
    f.y = fbm( st + 5.0*r + vec2(6.2, 1.2) + .15*u_time );
        
    vec2 g = vec2(0.);
    g.x = fbm( st + 5.0*f + vec2(1.2, 5.2) );
    g.y = fbm( st + 5.0*f + vec2(6.2, 1.2) );


    color += fbm( st + 4.0*g );

    color-= distance(u_mouse.xy/u_resolution.xy, st)*3.;

    gl_FragColor = vec4(color,1.0);
}