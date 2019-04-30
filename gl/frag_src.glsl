precision mediump float;
uniform vec3 color;
uniform float scale;

#pragma glslify: import('./common.glsl')
void main() {
  float r = 0.0, delta = 0.0, alpha = 1.0;
    vec2 cxy = 2.0 * gl_PointCoord - 1.0;
    r = dot(cxy, cxy);
    if (r > 1.0*scale) {
        discard;
    }
  gl_FragColor = vec4(color, 1);
}