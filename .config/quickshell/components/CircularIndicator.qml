import QtQuick

import qs.components
import qs.services

CircularProgressBar {
  property string textContent: ""
  property string textColor: UI.clrFg

  radius: 16
  progress: Brightness.rawPercentage

  Text {
    text: textContent
    color: textColor
    anchors.centerIn: parent
  }
}
