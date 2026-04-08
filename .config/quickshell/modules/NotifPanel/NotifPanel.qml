import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

import qs.components
import qs.services


Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: panel

      required property var modelData

      screen: modelData
      WlrLayershell.layer: WlrLayer.Overlay
      exclusiveZone: 0

      mask: Region { item: maskRect }

      implicitWidth: 350

      anchors {
        top: true
        right: true
        bottom: true
        left: true
      }

      margins {
        top: 32
        right: 32
        bottom: 32
      }

      visible: modelData.name == Hyprland.focusedMonitor.name

      color: "transparent"

      Rectangle {
        id: maskRect

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        width: UI.notifWidth
        height: notifList.height

        color: "transparent"

        Column {
          id: notifList

          anchors.top: parent.top
          anchors.right: parent.right
          anchors.left: parent.left

          spacing: 12

          Repeater {
            model: {
              return Notifs.list
            }
            delegate: NotifComp {
              required property var modelData
              required property real index

              notif: modelData
              idx: index
            }
          }
        }
      }
    }
  }
}
