import QtQuick

import qs.services
import qs.components

Rectangle {
  id: root

  required property bool value
  required property string text

  width: text.width + 24
  height: text.height + 12
  color: value ? UI.clrPrimary : UI.clrBgLt
  radius: 16

  Behavior on color {
    ColorAnimation { duration: 100 }
  }

  IconText {
    id: text

    anchors.centerIn: parent

    textContent: root.text
    icon: value ? "" : ""
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      value = !value
    }
  }
}
