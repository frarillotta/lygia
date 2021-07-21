
// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
float PI = 3.14155925;

#include "../space/ratio.glsl"

float sdSphere(vec3 p, float r) {
    return length(p)-r;
}

vec2 mousePos = (u_mouse/u_resolution.xy)-.5;

mat4 rotationMatrix(vec3 axis, float angle) {
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;
    
    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
                oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
                oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
                0.0,                                0.0,                                0.0,                                1.0);
}

vec3 rotate(vec3 v, vec3 axis, float angle) {
	mat4 m = rotationMatrix(axis, angle);
	return (m * vec4(v, 1.0)).xyz;
}

float sdBox( vec3 p, vec3 b )
{
  vec3 q = abs(p) - b;
  return length(max(q,0.0)) + min(max(q.x,max(q.y,q.z)),0.0);
}

// polynomial smooth min (k = 0.1);
float smin( float a, float b, float k )
{
    float h = clamp( 0.5+0.5*(b-a)/k, 0.0, 1.0 );
    return mix( b, a, h ) - k*h*(1.0-h);
}

float sdf(vec3 p) {
    vec3 p1 = rotate(p, vec3(1.), u_time/2.);
    
    float box = smin(sdBox(p1, vec3(0.2)), sdSphere(p, 0.2), .2);

    float sphere = sdSphere(p - vec3(.5, .4908, 0.), 0.2);

    return smin(box, sphere, .4);
}

vec3 calcNormal( in vec3 p ) // for function f(p)
{
    const float eps = 0.0001; // or some other value
    const vec2 h = vec2(eps,0);
    return normalize( vec3(sdf(p+h.xyy) - sdf(p-h.xyy),
                           sdf(p+h.yxy) - sdf(p-h.yxy),
                           sdf(p+h.yyx) - sdf(p-h.yyx) ) );
}

#include "../filter/dither/dither8x8.glsl"

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st = ratio(st, u_resolution);
    vec3 color = vec3(0.);

    float dist = length(st - vec2(0.5));
    vec3 bg = mix(vec3(0.), vec3(.3), dist);
    vec3 camPos = vec3(0., 0., 3.);
    vec3 ray = normalize(vec3(st - .5, -1.5));

    //pixelation
    float grid = u_resolution.x/3.;
    vec3 ray_i = floor(ray * grid)/grid;
    // ray = ray_i;

    vec3 rayPos = camPos;
    float t = 0.;
    float tMax = 5.;
    for (int i = 0; i < 256; i++) {
        vec3 pos = camPos + t*ray;
        float h = sdf(pos);
        if (h < 0.0001 || t > tMax) {
            break; 
        }
        t += h;
    }

    color = bg; 

    if (t < tMax) {
        vec3 pos = camPos + t*ray;
        color = vec3(1.);
        vec3 normal = calcNormal(pos);
        color = normal;
        float diff = dot(vec3(1.), normal);
        color = vec3(diff);
        float fresnel = pow(1. + dot(ray, normal), 1.);
        color = vec3(fresnel);
        color = mix(color, bg, -fresnel);
    }
    color = vec3(dither8x8(gl_FragCoord.xy, color));


    gl_FragColor = vec4(color,1.0);
}