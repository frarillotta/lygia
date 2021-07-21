#ifdef GL_ES
precision mediump float;
#endif

#ifndef FNC_RAYSSDF
#define FNC_RAYSSDF

#ifndef PI
#define PI 3.1415926535897932384626433832795
#endif

#ifndef TAU
#define TAU 6.2831853071795864769252867665590
#endif

float raysSDF(vec2 st, int N) {

    st -= .5;
    return fract(atan(st.y, st.x)/TAU*float(N));

}

#endif