#ifdef GL_ES
precision mediump float;
#endif

#ifndef FNC_FLIP
#define FNC_FLIP

float flip(float v, float pct) {

    return mix(v, 1.-v, pct);

}

#endif