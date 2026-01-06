import QtQuick

import qs.services

Row {
  property string textContent: "null"
  property string textColor: UI.clrFg
  property real fontSize: UI.txtSize
  property real fontWeight: UI.txtWeight

  property string icon: ""
  property string iconColor: textColor
  property real iconSize: 18

  spacing: 4

  Text {
    color: iconColor
    font.pixelSize: iconSize
    font.weight: fontWeight

    anchors.verticalCenter: parent.verticalCenter

    text: icon
  }

  Text {
    color: textColor
    font.pixelSize: fontSize
    font.weight: fontWeight

    anchors.verticalCenter: parent.verticalCenter

    text: textContent
  }
}
