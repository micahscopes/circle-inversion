precision mediump float;
attribute vec2 position;
uniform float viewportRatio;
uniform float scale;
uniform float pointSize;

#pragma glslify: import('./common.glsl')

void main() {
  gl_PointSize = pointSize;
  vec2 x = reflect(position, circle(vec2(0.5,0.2), vec2(0.5, 0.8), vec2(0.3, 0.2)));
  gl_Position =
      vec4(scale * x[0] * viewportRatio, scale * x  [1], 0, 1);
}