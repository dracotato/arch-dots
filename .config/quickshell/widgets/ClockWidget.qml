import QtQuick

import qs.services

Text {
  property string textColor: "#eee"
  property real fontSize: 16
  property real fontWeight: 500

  color: textColor
  font.pixelSize: fontSize
  font.weight: fontWeight

  text: Time.time
}
