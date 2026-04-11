import QtQuick

import qs.services
import qs.components

Rectangle {
  id: root

  property string icon: ""

  signal clicked(var event)

  implicitWidth: 40
  implicitHeight: implicitWidth

  color: area.containsMouse ? UI.clrBgLt : UI.clrBgLtr
  radius: height/2

  Behavior on color {
    ColorAnimation { duration: 100 }
  }

  MouseArea {
    id: area

    anchors.fill: parent

    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true

    onClicked: (event) => {
      root.clicked(event)
    }
  }

  Text {
    id: content

    anchors.centerIn: parent

    text: root.icon
    font.pixelSize: UI.iconSize
  }
}
