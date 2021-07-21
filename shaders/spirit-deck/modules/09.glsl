#ifdef GL_ES
precision mediump float;
#endif

#ifndef FNC_FILL
#define FNC_FILL

float fill(float x, float size) {
    return 1.-step(size, x);
}

#endif