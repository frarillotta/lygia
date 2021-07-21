#ifdef GL_ES
precision mediump float;
#endif

#ifndef FNC_TRISDF
#define FNC_TRISDF

float triSDF(vec2 st) {

    st = (st*2.-1.)*2.;
    return max(abs(st.x) * 0.866025 +st.y * 0.5, -st.y * 0.5);

}

#endif