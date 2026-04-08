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

      property bool show: false
      property string icon: ""
      property string text: "This is an OSD."

      screen: modelData
      WlrLayershell.layer: WlrLayer.Overlay
      exclusiveZone: 0
      mask: Region {}

      margins.bottom: UI.osdScreenPad

      anchors {
        right: true
        bottom: true
        left: true
      }

      visible: show && modelData.name == Hyprland.focusedMonitor.name

      // +1 to prevent weird clipping issue
      implicitHeight: osd.height + 1

      color: "transparent"

      Connections {
        target: Osd
        function onOsd(icon, text) {
          panel.icon = icon
          panel.text = text
          panel.show = true
          // ensure the full interval is used
          timer.running = false
          timer.running = true
        }
      }

      Timer {
        id: timer

        running: false
        interval: 3000
        onTriggered: {
          panel.show = false
        }
      }

      Rectangle {
        id: osd

        anchors.centerIn: parent

        width: row.implicitWidth + 24*2
        height: row.implicitHeight + 8*2
        radius: height / 2
        color: UI.clrBg
        border {
          color: UI.clrBgLt
          width: 2
        }

        RowLayout {
          id: row

          spacing: 12

          anchors.centerIn: parent

          Text {
            text: panel.icon
            font.pixelSize: UI.iconSizeBig
          }

          Text {
            Layout.fillWidth: true

            text: panel.text
            font.weight: UI.txtWeightBold
          }
        }
      }
    }
  }
}
