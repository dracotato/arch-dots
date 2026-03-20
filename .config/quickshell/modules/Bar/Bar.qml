import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Io
import Quickshell.Wayland

import qs.services
import qs.components

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: panel

      required property var modelData

      property real screenMargins: AppState.barFloat ? 8 : 0
      property real hPadding: AppState.barFloat ? UI.barHeight/2 : UI.barPadding
      property real borderRadius: AppState.barFloat ? UI.barHeight : 0

      screen: modelData
      WlrLayershell.layer: WlrLayer.Top

      implicitHeight: UI.barHeight

      color: "transparent"
      visible: AppState.barVisible

      margins {
        top: screenMargins
        left: screenMargins
        right: screenMargins
      }

      anchors {
        top: true
        left: true
        right: true
      }


      Rectangle {
        id: rootRect

        anchors.fill: parent

        color: UI.clrBg
        radius: panel.borderRadius

        RowLayout {
          anchors.fill: parent
          anchors.margins: UI.barPadding
          anchors.leftMargin: panel.hPadding
          anchors.rightMargin: panel.hPadding

          spacing: UI.barSectionGap

          Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            RowLayout {
              anchors.fill: parent

              spacing: UI.barComponentGap

              HyprWorkspaces {
                id: workspaces
                Layout.fillHeight: true
                Layout.fillWidth: true
                screen: modelData.name
              }
            }
          }

          MouseArea {
            id: clockArea

            Layout.fillHeight: true 
            width: clock.width + 16

            onClicked: {
              AppState.barPopupVisible = !AppState.barPopupVisible
            }

            Column {
              id: clock

              anchors.centerIn: parent

              spacing: -2

              Text {
                text: Time.format("h:mm:ss AP")
                font.weight: 700
                anchors.horizontalCenter: parent.horizontalCenter
              }

              Text {
                text: Time.format(`dddd, MMM dd'${Time.monthDaySuffix}'`)
                color: UI.clrFgLt
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 12
              }
            }
          }

          Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            RowLayout {
              anchors.left: parent.left
              anchors.verticalCenter: parent.verticalCenter
              spacing: UI.barComponentGap

              CaffeineWidget {}
            }

            RowLayout {
              anchors.top: parent.top
              anchors.bottom: parent.bottom
              anchors.right: parent.right
              spacing: UI.barComponentGap
              layoutDirection: Qt.RightToLeft

              BatteryWidget {}

              NetworkWidget {
                id: networkWidget
              }

              KbLayoutWidget {}

              BrightnessWidget {
                id: brightnessWidget
              }

              VolumeWidget {
                id: volumeWidget
              }
            }
          }
        }
        ControlCenter {
          panel: panel
          screen: modelData
        }
      }
    }
  }

  IpcHandler {
    target: "bar"

    function toggle() {
      AppState.barVisible = !AppState.barVisible
    }

    function togglePopup() {
      AppState.barPopupVisible = !AppState.barPopupVisible
    }

    function toggleFloat() {
      AppState.barFloat = !AppState.barFloat
    }
  }
}
