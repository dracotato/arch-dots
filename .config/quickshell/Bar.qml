import Quickshell
import QtQuick


Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      property real outerMargin: 8
      property real moduleMargin: 32
      property real componentMargin: 8

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
          id: container

          anchors.fill: parent
          anchors.margins: outerMargin

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
            anchors.leftMargin: moduleMargin

            spacing: componentMargin
            layoutDirection: Qt.RightToLeft

            BatteryWidget {
              id: battery

              anchors.top: parent.top
              anchors.bottom: parent.bottom
              anchors.verticalCenter: parent.verticalCenter

              textColor: textcolor
              fontWeight: 500
              fontSize: 16
            }

            NetworkWidget {
              id: network

              anchors.top: parent.top
              anchors.bottom: parent.bottom
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
}
