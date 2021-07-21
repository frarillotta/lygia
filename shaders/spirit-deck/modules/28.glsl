#ifdef GL_ES
precision mediump float;
#endif

#ifndef FNC_STARSDF
#define FNC_STARSDF

#ifndef PI
#define PI 3.1415926535897932384626433832795
#endif

#ifndef TAU
#define TAU 6.2831853071795864769252867665590
#endif

float starSDF(vec2 st, int V, float s) {

    st = st*4.-2.;
    float a = atan(st.y, st.x)/TAU;
    float seg = a * float(V);
    a = ((floor(seg) + .5)/float(V) + 
        mix(s, -s, step(.5, fract(seg))))
        * TAU;
    return abs(dot(vec2(cos(a), sin(a)), 
        st));

}

#endif