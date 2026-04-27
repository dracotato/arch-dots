import QtQuick

import qs.components
import qs.services

Rectangle {
  property bool active: Caffeine.active
  property string idleManager: "hypridle"
  property string startupCmd: "hyprctl dispatch exec hypridle"

  width: 32
  height: width

  color: active ? UI.clrPrimary : UI.clrBgLt
  radius: 999


  Behavior on color {
    ColorAnimation { duration: 100 }
  }

  MouseArea {
    anchors.fill: parent

    onClicked: Caffeine.active = !Caffeine.active
  }

  Text {
    id: icon

    anchors.centerIn: parent

    text: active ? "󰅶" : "󰾪"
  }
}
