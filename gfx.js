import glLib from './gl/lib.glsl'
const regl = require('regl')()
const camera = require('regl-camera')(regl, {
  center: [0, 2.5, 0]
})

let gl = function(s){
  return `precision mediump float;
  ${glLib}\n\n${s[0]}`
}

const bunny = require('bunny')
const normals = require('angle-normals')

window.bunny = bunny;
window.normals = normals;

const RAD = 4.0;

const drawBunny = regl({
  vert: gl`
    uniform vec3 a, b, c, d;
    uniform mat4 projection, view;
    attribute vec3 position, normal;
    varying vec3 vnormal;

    void main () {
      CGA3 sphere = sphere(a,b,c,d);
      vec3 x = reflect_glsl(position, sphere);
      vnormal = normal;
      gl_Position = projection * view * vec4(x, 1.0);
    }`,
  frag: gl`
    varying vec3 vnormal;
    void main () {
      gl_FragColor = vec4(abs(vnormal), 1.0);
    }`,
  attributes: {
    position: bunny.positions,
    normal: normals(bunny.cells, bunny.positions)
  },
  uniforms: {
    a: [-RAD,0,0],
    b: [RAD,0,0],
    c: [0,RAD,0],
    d: [0,0,RAD],
  },
  elements: bunny.cells
})

regl.frame(() => {
  camera((state) => {
    if (!state.dirty) return;
    regl.clear({color: [0, 0, 0, 1]})
    drawBunny()
  })
})