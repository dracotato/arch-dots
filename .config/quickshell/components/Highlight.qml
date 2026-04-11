import QtQuick

import qs.services

Rectangle {
  property string highlightClr: UI.clrBgLtr

  default property alias children: content.children

  implicitWidth: content.implicitWidth + 24
  implicitHeight: content.implicitHeight + 12

  color: highlightClr
  radius: height/2

  Row {
    id: content

    anchors.centerIn: parent

    spacing: 4
  }
}
