import Quickshell
import Quickshell.Wayland
import QtQuick

import qs.widgets
import qs.services
import qs.components

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData
      WlrLayershell.layer: WlrLayer.Top

      implicitHeight: UI.barHeight

      anchors {
        top: true
        left: true
        right: true
      }

      Rectangle {
        anchors.fill: parent

        color: UI.clrBg

        Row {
          id: leftSection

          anchors.top: parent.top
          anchors.right: clock.left
          anchors.bottom: parent.bottom
          anchors.left: parent.left
          anchors.rightMargin: UI.barSectionGap
          anchors.leftMargin: UI.barPadding

          spacing: UI.barComponentGap

          HyprWorkspaces {
            id: workspaces

            anchors.verticalCenter: parent.verticalCenter
          }
        }

        ClockWidget {
          id: clock

          anchors.centerIn: parent
        }

        Row {
          id: rightSection

          anchors.top: parent.top
          anchors.right: parent.right
          anchors.bottom: parent.bottom
          anchors.left: clock.right
          anchors.leftMargin: UI.barSectionGap // gap between clock
          anchors.rightMargin: UI.barPadding // gap between screen

          spacing: UI.barComponentGap
          layoutDirection: Qt.RightToLeft


          BatteryWidget {
            anchors.verticalCenter: parent.verticalCenter
          }

          NetworkWidget {
            anchors.verticalCenter: parent.verticalCenter
          }

          LayoutWidget {
            anchors.verticalCenter: parent.verticalCenter
          }

          BrightnessWidget {
            anchors.verticalCenter: parent.verticalCenter
          }

          VolumeWidget {
            anchors.verticalCenter: parent.verticalCenter
          }
        }
      }
    }
  }
}
