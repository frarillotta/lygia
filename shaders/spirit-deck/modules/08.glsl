#ifdef GL_ES
precision mediump float;
#endif

#ifndef FNC_CIRCLESDF
#define FNC_CIRCLESDF

float circleSDF(vec2 st) {

    return length(st-.5)*2.;

}

#endif