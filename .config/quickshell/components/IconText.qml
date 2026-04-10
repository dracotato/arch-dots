import QtQuick

import qs.services

Item {
  property string textContent: "null"
  property string textColor: UI.clrFg
  property real fontSize: UI.txtSize
  property real fontWeight: UI.txtWeight

  property string icon: ""
  property string iconColor: textColor
  property real iconSize: UI.iconSize

  implicitWidth: content.implicitWidth
  implicitHeight: content.implicitHeight

  Row {
    id: content

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
}
