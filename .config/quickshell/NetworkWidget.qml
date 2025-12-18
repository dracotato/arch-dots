import QtQuick

import qs.services

Row {
  readonly property Text text: text

  Text {
    id: text

    anchors.verticalCenter: parent.verticalCenter

    text: `${Network.name}`
  }
}
