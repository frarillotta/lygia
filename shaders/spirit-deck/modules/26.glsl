#ifdef GL_ES
precision mediump float;
#endif

#ifndef FNC_POLYSDF
#define FNC_POLYSDF

#ifndef PI
#define PI 3.1415926535897932384626433832795
#endif

#ifndef TAU
#define TAU 6.2831853071795864769252867665590
#endif

float polySDF(vec2 st, int V) {

    st = st*2.-1.;
    float a = atan(st.x, st.y)+PI;
    float r = length(st);
    float v = TAU/float(V);
    return cos(floor(.5+a/v)*v-a)*r;

}

#endif