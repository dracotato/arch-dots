import QtQuick

import qs.components
import qs.services

CircularIndicator {
  textContent: FocusTime.mode == "focus" ? (FocusTime.paused ? "󰚌" : "") : "󱔐"
  progress: FocusTime.percentage

  MouseArea {
    anchors.fill: parent

    acceptedButtons: Qt.LeftButton | Qt.RightButton

    onClicked: (event) => {
      switch (event.button) {
        case Qt.LeftButton:
          FocusTime.togglePause()
          break;
        case Qt.RightButton:
          FocusTime.nextMode()
          break;
      }
    }
  }
}
