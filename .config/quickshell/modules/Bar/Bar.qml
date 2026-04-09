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

      property real screenMargins: AppState.barFloat ? 256 : 0
      property real hPadding: AppState.barFloat ? UI.barHeight/2 : UI.barPadding
      property real borderRadius: AppState.barFloat ? UI.barHeight : 0

      screen: modelData
      WlrLayershell.layer: controlCenter.visible ? WlrLayer.Overlay : WlrLayer.Bottom

      implicitHeight: UI.barHeight

      color: "transparent"
      visible: AppState.barVisible

      margins {
        top: AppState.barFloat ? 8 : 0
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
              AppState.controlCenterVisible = !AppState.controlCenterVisible
            }

            Column {
              id: clock

              anchors.centerIn: parent

              spacing: -2

              Text {
                text: Time.format("h:mm:ss AP")
                anchors.horizontalCenter: parent.horizontalCenter
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
              SettingsWidget {}
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

              FocusWidget {
                id: focusWidget
              }
            }
          }
        }
        ControlCenter {
          id: controlCenter

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

    function toggleCenter() {
      AppState.controlCenterVisible = !AppState.controlCenterVisible
    }

    function toggleFloat() {
      AppState.barFloat = !AppState.barFloat
    }
  }
}
