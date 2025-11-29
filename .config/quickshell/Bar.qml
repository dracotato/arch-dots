import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects


Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      property real margin: 8
      property string bgcolor: "#111"
      property string textcolor: "#eee"

      implicitWidth: container.implicitWidth + margin * 2
      implicitHeight: container.implicitHeight + margin * 2

      color: "transparent"

      anchors {
        top: true
        left: true
        right: true
      }

      Rectangle {
        anchors.fill: parent

        color: bgcolor

        RowLayout {
          id: container
          anchors.fill: parent

          ClockWidget {
            id: clock
            anchors.centerIn: parent

            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            color: textcolor
            font.weight: 500
            font.pointSize: 12
          }

          BatteryWidget {
            id: battery

            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.rightMargin: 8

            color: textcolor
            font.weight: 500
            font.pointSize: 12
          }
        }
      }
    }
  }
}
