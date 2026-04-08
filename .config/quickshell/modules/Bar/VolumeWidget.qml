import QtQuick

import Quickshell

import qs.components
import qs.services

CircularIndicator {
  id: root

  progress: Volume.muted ? 0 : Volume.rawPercentage
  textContent: Volume.icon

  MouseArea {
    anchors.fill: parent

    onWheel: (scroll) => {
      let delta = scroll.angleDelta.y/2400
      Volume.setVolume(Volume.rawPercentage+delta)
    }
  }
}
