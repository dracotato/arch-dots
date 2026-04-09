import QtQuick

import Quickshell
import Quickshell.Wayland

import qs.services
import qs.components

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: root

      required property var modelData

      screen: modelData

      visible: FocusTime.mode == "break"
      focusable: true
      color: "transparent"

      exclusionMode: ExclusionMode.Ignore
      WlrLayershell.layer: WlrLayer.Overlay
      anchors {
        top: true
        right: true
        bottom: true
        left: true
      }

      Item {
        focus: true
        Keys.onPressed: (event) => {
          if (event.key == Qt.Key_Escape) {
            event.accepted = true;
            FocusTime.setMode("focus") // quit break mode
          }
        }
      }

      Rectangle {
        anchors.fill: parent

        color: "black"
        opacity: .8
      }

      Column {
        anchors.centerIn: parent

        spacing: 8

        Text {
          text: "Go touch some grass."
          color: UI.clrFgLt
          font.pixelSize: 32
          font.weight: 700
        }

        Text {
          anchors.horizontalCenter: parent.horizontalCenter
          text: Utils.formatDuration(FocusTime.breakDuration - FocusTime.timeSpent)
          color: UI.clrPrimaryLt
          font.pixelSize: 20
        }
      }
    }
  }
}
