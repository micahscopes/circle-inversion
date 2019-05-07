import glLib from './gl/lib.glsl'
const regl = require('regl')()
const camera = require('regl-camera')(regl, {
  center: [0, 0.1, 0.05],
  up: [0,-1,0]
})

let gl = function(s){
  return `precision mediump float;
  ${glLib}\n\n${s[0]}`
}

const bunny = require('bunny')
const normals = require('angle-normals')

const NOISE_SIZE = 1/5
let randomPoint = (size) => () => [
  Math.random()*size,
  Math.random()*size,
  Math.random()*size
]

let makeBunnyNoise = () =>bunny.positions.map(randomPoint(NOISE_SIZE))
let bunnyNoise = regl.buffer({
  data: makeBunnyNoise()
})

window.bunny = bunny
window.normals = normals

const RAD = 1.0

const drawBunny = regl({
  vert: gl`
    uniform vec3 a, b, c, d;
    uniform mat4 projection, view;
    attribute vec3 position, noise, normal;
    varying vec3 vnormal;

    void main () {
      CGA3 sphere = sphere(a,b,c,d);
      vec3 x = reflect_glsl(position+noise, sphere);
      vnormal = normal;
      gl_PointSize = 4.0;
      gl_Position = projection * view * vec4(x, 1.0);
    }`,
  frag: gl`
    varying vec3 vnormal;
    void main () {
      gl_FragColor = vec4(vnormal+vec3(0.4,0.4,0.4), 0.8);
    }`,
  blend: {
    enable: true,
    func: {
      srcRGB: 'src alpha',
      srcAlpha: 1,
      dstRGB: 'one minus src alpha',
      dstAlpha: 1
    },
    equation: {
      rgb: 'add',
      alpha: 'add'
    },
    color: [0, 0, 0, 0]
  },
  attributes: {
    position: bunny.positions,
    noise: bunnyNoise,
    normal: normals(bunny.cells, bunny.positions)
  },
  count: bunny.positions.length,
  primitive: 'points',
  uniforms: {
    a: [-RAD,0,0],
    b: [RAD,0,0],
    c: [0,RAD,0],
    d: [0,0,RAD],
  },
})

regl.frame(() => {
  camera((state) => {
    // if (!state.dirty) return;
    bunnyNoise({
      data: makeBunnyNoise()
    })
    // regl.clear({color: [0, 0, 0, 1]})
    drawBunny()
  })
})