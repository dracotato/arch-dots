import QtQuick

import qs.components
import qs.services

CircularIndicator {
  progress: Brightness.percentage/100
  textContent: "󰃠"

  MouseArea {
    anchors.fill: parent
    onWheel: (scroll) => {
      let delta = scroll.angleDelta.y/2400
      let increment = delta*100
      // pervent unresponsiveness for very small positive values
      if (increment > 0 && increment < 1) {
        increment = 1
      } else {
        increment = Math.floor(increment)
      }
      Brightness.setBrightness(Brightness.percentage+increment)
    }
  }
}
