import QtQuick

import qs.components
import qs.services

CircularProgressBar {
  property string textContent: ""
  property string textColor: UI.clrFg
  property real fontSize: UI.txtSize
  property real fontWeight: UI.txtWeight

  radius: 16
  progress: Brightness.rawPercentage

  Text {
    text: textContent
    color: textColor
    font.pixelSize: fontSize
    font.weight: fontWeight
    anchors.centerIn: parent
  }
}
