import QtQuick

import Quickshell.Io

import qs.components
import qs.services

Rectangle {
  width: 32
  height: width

  color: AppState.settingsVisible ? UI.clrPrimary : UI.clrBgLt
  radius: 999

  transform: Rotation {
    origin.x: width/2; origin.y: height/2
    angle: AppState.settingsVisible ? 90 : 0

    Behavior on angle {
      NumberAnimation {
        duration: 250
        easing.type: Easing.InOutQuad
      }
    }
  }

  Behavior on color {
    ColorAnimation { duration: 100 }
  }

  MouseArea {
    anchors.fill: parent

    onClicked: {
      AppState.settingsVisible = !AppState.settingsVisible
    }
  }

  Text {
    id: icon

    anchors.centerIn: parent

    text: ""
  }
}
