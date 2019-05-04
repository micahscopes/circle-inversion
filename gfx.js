import colorConvert from 'color-convert';
import ReglComponent from 'idyll-regl-component';
import {define} from 'remount';
import mouseChange from 'mouse-change';


import frag from './gl/frag.glsl'
import vert from './gl/vert.glsl'
import circle_center_vert from './gl/circle_center_vert.glsl'

let square_size = 100;
let square = [];
for (let i = 0; i < square_size; i++) {
  for (let j = 0; j < square_size; j++) {
    let jitterX = Math.random()/100
    let jitterY = Math.random()/100
    square.push([i / square_size/2 - 0.25 +jitterX, j / square_size/2 - 0.25 + jitterY])
  }
}

window.square = square

class Gfx extends ReglComponent {
  initialize(r, node) {
    this.rect = node.getBoundingClientRect()
    var width = this.rect.width;
    var height = width / 2;

    node.style.height = height + 'px';
    const regl = r(node);
    this.a = JSON.parse(this.props.a)
    this.b = JSON.parse(this.props.b)
    this.c = JSON.parse(this.props.c)

    var controlPoints = regl.buffer({
      data: [this.a, this.b, this.c],
      length: 3,
    })

    mouseChange(node, (buttons, x, y, mods) => {
      this.a = [(x/this.rect.width*2 - 1)*2/this.props.scale, (-y/this.rect.height+0.5)*2/this.props.scale]
      controlPoints({
        data: [this.a, this.b, this.c],
        length: 3
      });  
    })

    regl.clear({color: [0, 0, 0, 1], depth: 1});

    var squarePoints = regl.buffer({
      data: square,
      length: square.length,
    })

    let drawTransformedPoint = regl({
      frag: frag,
      vert: vert,

      attributes: {position: squarePoints},
      count: square.length,
      primitive: 'points',

      uniforms: {
        color: regl.prop('color'),
        viewportRatio: ({viewportWidth, viewportHeight}) =>
            viewportHeight / viewportWidth,
        scale: regl.prop('scale'),
        pointSize: regl.prop('pointSize'),
        a: () => this.a,
        b: () => this.b,
        c: () => this.c,
      },

      lineWidth: 4,
    });

    let drawCircle = regl({
      frag:  `
      precision mediump float;
      uniform float scale;
      uniform vec4 color;
      varying vec2 center;
      varying float radius;
      varying vec2 uv;
      
      void main() {
        float r = 0.0;
        vec2 cxy = (uv - center);
        r = dot(cxy, cxy);
        float stroke = 0.005;
        if (r > pow(radius+stroke, 2.0) || r < pow(radius-stroke, 2.0)) {
            discard;
        }
        gl_FragColor = color;
      }
    
    `,
      vert: circle_center_vert,
      attributes: {position: 
        regl.buffer([-1, -1, 1, -1, 1, 1, -1, -1, 1, 1, -1, 1])
      },
      blend: {
        enable: true,
      },  
      count: 6,
      uniforms: {
        viewportRatio: ({viewportWidth, viewportHeight}) =>
            viewportHeight / viewportWidth,
        scale: regl.prop('scale'),
        color: regl.prop('color'),
        pointSize: 2,
        a: () => this.a,
        b: () => this.b,
        c: () => this.c,
      },

    })

    let pointDrawer = (points, length) => regl({
      frag: `
      precision mediump float;
      uniform float scale;
      uniform vec4 color;
      
      void main() {
        float r = 0.0;
        vec2 cxy = 2.0 * gl_PointCoord - 1.0;
        r = dot(cxy, cxy);
        if (r > 1.0) {
            discard;
        }
        gl_FragColor = color;
      }`,
      vert: `
        precision mediump float;
        attribute vec2 position;
        uniform float viewportRatio;
        uniform float scale;
        uniform float pointSize;

        void main() {
          gl_PointSize = pointSize;
          gl_Position =
              vec4(scale * position[0] * viewportRatio, scale * position[1], 0, 1);
        }
      `,
      blend: {
        enable: true,
      },  
      attributes: {position: points},
      count: length,
      primitive: 'points',
      uniforms: {
        viewportRatio: ({viewportWidth, viewportHeight}) =>
            viewportHeight / viewportWidth,
        scale: regl.prop('scale'),
        pointSize: regl.prop('pointSize'),
        color: regl.prop('color'),
      },
    })

    let drawUntransformedPoints = pointDrawer(squarePoints, square.length)
    let drawCirclePoints = pointDrawer(controlPoints, 3)
    regl.frame(({tick}) => {
      this.rect = node.getBoundingClientRect()

      regl.clear({color: [0, 0, 0, 1], depth: 1});

      let scale = Number(this.props.scale);
      

      
      drawTransformedPoint(
        {
          primitive: 'points', 
          scale: scale, 
          pointSize: 3,
          color: [1, 0, 0.5]
        }
      );
      
      drawUntransformedPoints({
        scale: scale,
        pointSize: 3,
        color: [0.2,0.7,1.0, 1]
      });

      drawCirclePoints({
        scale: scale,
        pointSize: 20,
        color: [1, 0.8, 0, 1]
      });      
      
      drawCircle({
        scale: scale,
        color: [1, 0.8, 0, 1]
        // color: [0,0.1,0.3,1]
      })

    });
  }
}

export default Gfx;

define({'x-gfx': {component: Gfx, attributes: ['scale', 'color', 'a','b','c']}});
