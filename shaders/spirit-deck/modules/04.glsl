#ifdef GL_ES
precision mediump float;
#endif

#ifndef FNC_STROKE
#define FNC_STROKE

float stroke(float x, float s, float w) {
    float d= step(s, x+w*.5) - step(s, x-w*.5);
    return clamp(d, 0., 1.);
}

#endif