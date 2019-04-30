import ReglComponent from "idyll-regl-component";
import colorConvert from "color-convert";
import { define } from "remount";

import frag from "./gl/frag.glsl"
import vert from "./gl/vert.glsl"

let square_size = 100
let square = []
for(let i=0; i<square_size; i++){
  for(let j=0; j<square_size; j++){
    square.push([i/square_size - 0.5, j/square_size - 0.5])
  }
}

window.square = square

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
      frag: frag,
      vert: vert,

      attributes: {
        position: square
      },

      primitive: "points",

      count: square_size*square_size,

      uniforms: {
        color: regl.prop('color'),
        viewportRatio: ({viewportWidth, viewportHeight}) => viewportHeight/viewportWidth,
        scale: regl.prop('scale'),
        pointSize: () => 3,
      },

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
