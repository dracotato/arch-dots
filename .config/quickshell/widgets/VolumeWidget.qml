import QtQuick

import Quickshell

import qs.components
import qs.services

CircularIndicator {
  id: root

  progress: Volume.muted ? 0 : Volume.rawPercentage
  textContent: {
    if (Volume.rawPercentage <= 0 || Volume.muted) {
      return "󰝟";
    } else if (Volume.rawPercentage > 1) {
      return "󱄡";
    } else if (Volume.rawPercentage > .06) {
      return "󰕾";
    } else if (Volume.rawPercentage > .01) {
      return "󰖀";
    } else {
      return "󰕿";
    }
  }

  MouseArea {
    anchors.fill: parent

    onWheel: (scroll) => {
      let delta = scroll.angleDelta.y/2400
      Volume.setVolume(Volume.rawPercentage+delta)
    }
  }
}
