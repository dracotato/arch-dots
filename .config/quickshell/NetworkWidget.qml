import QtQuick

import qs.services

Row {
  property string textColor: "#eee"
  property real fontSize: 16
  property real fontWeight: 500

  Text {
    id: text

    color: textColor
    font.pixelSize: fontSize
    font.weight: fontWeight

    anchors.verticalCenter: parent.verticalCenter

    text: `${Network.name}`
  }
}
