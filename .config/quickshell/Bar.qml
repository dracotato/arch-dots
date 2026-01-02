import Quickshell
import Quickshell.Wayland
import QtQuick

import qs.widgets

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData
      WlrLayershell.layer: WlrLayer.Top

      property real outerMargin: 8 // screen gap
      property real sectionGap: 32
      property real componentGap: 12

      property string bgcolor: "#111"
      property string textcolor: "#eee"

      implicitHeight: 48

      color: "transparent"

      anchors {
        top: true
        left: true
        right: true
      }

      Rectangle {
        anchors.fill: parent

        color: bgcolor

        Row {
          id: leftSection

          anchors.top: parent.top
          anchors.right: clock.left
          anchors.bottom: parent.bottom
          anchors.left: parent.left
          anchors.rightMargin: sectionGap // gap between clock
          anchors.leftMargin: outerMargin // gap between screen

          spacing: componentGap

          HyprWorkspaces {
            id: workspaces

            anchors.verticalCenter: parent.verticalCenter

            textColor: textcolor
            fontWeight: 500
            fontSize: 16
          }
        }

        ClockWidget {
          id: clock

          anchors.centerIn: parent

          textColor: textcolor
          fontWeight: 500
          fontSize: 16
        }

        Row {
          id: rightSection

          anchors.top: parent.top
          anchors.right: parent.right
          anchors.bottom: parent.bottom
          anchors.left: clock.right
          anchors.leftMargin: sectionGap // gap between clock
          anchors.rightMargin: outerMargin // gap between screen

          spacing: componentGap
          layoutDirection: Qt.RightToLeft


          BatteryWidget {
            id: battery

            anchors.verticalCenter: parent.verticalCenter

            textColor: textcolor
            fontWeight: 500
            fontSize: 16
          }

          NetworkWidget {
            id: network

            anchors.verticalCenter: parent.verticalCenter

            textColor: textcolor
            fontWeight: 500
            fontSize: 16
          }

          LayoutWidget {
            id: layout

            anchors.verticalCenter: parent.verticalCenter

            textColor: textcolor
            fontWeight: 500
            fontSize: 16
          }
        }
      }
    }
  }
}
