import TangleText from "react-tangle-text";
import { define } from "remount";

define({
  "tangle-text": {
    component: TangleText,
    attributes: [
      "value",
      "onChange",
      "onInput",
      "className",
      "style",
      "min",
      "max",
      "step",
      "pixelDistance",
      "format",
      "disabled"
    ]
  }
});
