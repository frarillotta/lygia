#ifdef GL_ES
precision mediump float;
#endif

#ifndef FNC_RECTSDF
#define FNC_RECTSDF

float rectSDF(vec2 st, vec2 s) {

    st = st*2.-1.;
    return max(abs(st.x/s.x),
        abs(st.y/s.y));

}

#endif