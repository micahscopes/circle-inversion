precision mediump float;
attribute vec2 position;
uniform float viewportRatio;
uniform float scale;
uniform float pointSize;
uniform vec2 a;
uniform vec2 b;
uniform vec2 c;

#pragma glslify: import('./common.glsl')

void main() {
  gl_PointSize = pointSize;
  vec2 x = reflect_glsl(position, circle(a,b,c));

  gl_Position =
      vec4(scale * x[0] * viewportRatio, scale * x  [1], 0, 1);
}