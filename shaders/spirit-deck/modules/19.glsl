#ifdef GL_ES
precision mediump float;
#endif

#ifndef FNC_ROTATE
#define FNC_ROTATE

vec2 rotate(vec2 st, float a) {
    st = mat2(cos(a), -sin(a),
                sin(a), cos(a))*(st-.5);
    return st+.5;
}

#endif