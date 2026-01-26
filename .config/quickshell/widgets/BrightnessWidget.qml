import QtQuick

import qs.components
import qs.services

CircularIndicator {
  progress: Brightness.percentage/100
  textContent: "󰃠"

  MouseArea {
    anchors.fill: parent
    onWheel: (scroll) => {
      let delta = scroll.angleDelta.y/5
      Brightness.setBrightness(Brightness.percentage+delta)
    }
  }
}
