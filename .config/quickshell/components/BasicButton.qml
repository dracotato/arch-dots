import QtQuick

import qs.services

Rectangle {
  id: root

  property string text: ""
  property string txtColor: UI.clrFg
  property string hoverTxtColor: UI.clrFgLt
  property real txtSize: UI.txtSize
  property real txtWeight: UI.txtWeight
  property real pad: 8

  signal clicked(var event)

  color: "transparent"

  width: text.width + pad
  height: text.height + pad

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
    id: text

    anchors.centerIn: parent

    text: root.text
    color: area.containsMouse ? root.hoverTxtColor : root.txtColor
    font.pixelSize: root.txtSize
    font.weight: root.txtWeight

    Behavior on color {
      ColorAnimation { duration: 100 }
    }
  }
}
