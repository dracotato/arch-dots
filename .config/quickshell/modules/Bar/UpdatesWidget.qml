import QtQuick

import Quickshell

import qs.components
import qs.services

IconText {
  id: root

  icon: "󰚰"
  textContent: System.packageUpdates > 0 ? `${System.packageUpdates} Updates` : "Up to date"

  MouseArea {
    anchors.fill: parent
    onClicked: Quickshell.execDetached(["sh", "-c", "kitty yay -Syu"])
  }
}
