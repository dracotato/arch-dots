import Quickshell
import QtQuick

import qs.widgets

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      property real outerMargin: 8 // screen gap
      property real moduleGap: 32
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

        ClockWidget {
          id: clock

          anchors.centerIn: parent

          textColor: textcolor
          fontWeight: 500
          fontSize: 16
        }

        Row {
          id: statsContainer

          anchors.top: parent.top
          anchors.right: parent.right
          anchors.bottom: parent.bottom
          anchors.left: clock.right
          anchors.leftMargin: moduleGap // gap between clock
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
