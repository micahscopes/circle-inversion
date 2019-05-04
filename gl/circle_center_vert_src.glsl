precision mediump float;
uniform vec2 a;
uniform vec2 b;
uniform vec2 c;
uniform float viewportRatio;
uniform float scale;
uniform float pointSize;
attribute vec2 position;
varying vec2 center;
varying float radius;
varying vec2 uv;

#pragma glslify: import('./common.glsl')

void main(){
    gl_PointSize = pointSize;
    center = circle_center(a,b,c);
    radius = circle_radius(a,b,c);
    uv = vec2(position.x/viewportRatio, position.y)/scale;
    gl_Position = 
        vec4(position, 0, 1);
}