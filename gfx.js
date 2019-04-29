import ReglComponent from "idyll-regl-component";
import colorConvert from "color-convert";
import { define } from "remount";

class Gfx extends ReglComponent {
  initialize(r, node) {
    var width = node.getBoundingClientRect().width;
    var height = width / 2;
    node.style.height = height + "px";
    const regl = r(node);

    regl.clear({
      color: [0, 0, 0, 1],
      depth: 1
    });

    let drawSegments = regl({
      frag: ({primitive}) => `
        precision mediump float;
        uniform vec3 color;
        uniform float scale;
        void main() {
          float r = 0.0, delta = 0.0, alpha = 1.0;
          ${ primitive == "points" ?
            `
            vec2 cxy = 2.0 * gl_PointCoord - 1.0;
            r = dot(cxy, cxy);
            if (r > 1.0*scale) {
                discard;
            }` :
            '\n'
          }
          gl_FragColor = vec4(color, 1);
        }`,

      vert: `
        precision mediump float;
        attribute vec2 position;
        uniform float viewportRatio;
        uniform float scale;
        uniform float pointSize;
        
        void main() {
          gl_PointSize = pointSize;
          gl_Position = vec4(scale*position[0]*viewportRatio, scale*position[1], 0, 1);
        }`,

      context: {
        primitive: regl.prop('primitive')
      },

      attributes: {
        position: [[-1, 0], [0, 1], [1, 0], [0, -1], [0,0]]
      },

      uniforms: {
        color: regl.prop('color'),
        viewportRatio: ({viewportWidth, viewportHeight}) => viewportHeight/viewportWidth,
        scale: regl.prop('scale'),
        pointSize: () => 30,
      },

      primitive: regl.context('primitive'),

      elements: regl.elements({
        count: 5,
        data: new Uint8Array([0,1,2,3,4]),
      }),
      
      lineWidth: 4,
    });

    regl.frame(({ tick }) => {
      regl.clear({
        color: [0, 0, 0, 1],
        depth: 1
      });

      let scale = Number(this.props.scale);

      drawSegments({
        primitive: "points",
        scale: scale,
        color: [1,0,0]
      });

      drawSegments({
        primitive: "line strip",
        scale: scale,
        color: colorConvert.keyword.rgb(this.props.color).map(x => x/255.0)
      });
    });
  }
}

export default Gfx;

define({
  "x-gfx": {
    component: Gfx,
    attributes: ["scale", "color"]
  }
});
