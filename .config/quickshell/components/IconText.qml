import QtQuick


Row {
  property string textContent: "null"
  property string textColor: "#eee"
  property real fontSize: 16
  property real fontWeight: 500

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
