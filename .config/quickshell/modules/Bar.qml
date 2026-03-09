import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.Mpris
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

import qs.widgets
import qs.services
import qs.components

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: panel

      required property var modelData

      screen: modelData
      WlrLayershell.layer: WlrLayer.Top

      implicitHeight: UI.barHeight

      visible: AppState.barVisible

      anchors {
        top: true
        left: true
        right: true
      }

      Rectangle {
        id: rootRect

        anchors.fill: parent

        color: UI.clrBg

        RowLayout {
          anchors.fill: parent
          anchors.margins: UI.barPadding

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

            Text {
              id: clock

              text: Time.time
              anchors.centerIn: parent
            }
          }

          Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

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

        PopupWindow {
          id: popupWindow

          anchor.window: panel
          anchor.rect.x: panel.width / 2 - this.width / 2
          anchor.rect.y: panel.height

          color: "transparent"

          visible: popoutRect.y != -popoutRect.height

          implicitWidth: popoutRect.width
          implicitHeight: popoutRect.height

          Rectangle {
            id: popoutRect

            y: AppState.barPopupVisible && modelData.name == Hyprland.focusedMonitor.name ? 0 : -height

            Behavior on y {
              NumberAnimation { duration: 400; easing.type: Easing.InOutQuad }
            }

            implicitWidth: panel.width/3
            implicitHeight: 300
            color: UI.clrBg

            bottomLeftRadius: 8
            bottomRightRadius: 8

            ColumnLayout {
              id: popoutContent

              property bool isEmpty: Mpris.players.values.length + SystemTray.items.values.length == 0

              anchors.fill: parent
              anchors.topMargin: 32
              anchors.bottomMargin: 32

              spacing: 16

              Text {
                Layout.alignment: Qt.AlignHCenter

                visible: popoutContent.isEmpty
                color: UI.clrFgLt
                text: "Nothing to see here..."
              }

              ListView {
                id: trayView

                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32

                height: 32

                orientation: Qt.Horizontal
                spacing: 16

                model: SystemTray.items
                delegate: Image {
                  required property var modelData

                  height: trayView.height
                  width: height

                  source: modelData.icon

                  MouseArea {
                    anchors.fill: parent

                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                    onClicked: (event) => {
                      switch (event.button) {
                        case Qt.LeftButton:
                          modelData.activate()
                          break
                        case Qt.RightButton:
                          modelData.display(popupWindow, event.x+48, event.y+48)
                          break
                      }
                    }
                  }
                }
              }

              Rectangle {
                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32

                height: 2
                visible: !popoutContent.isEmpty

                color: UI.clrBgLt
              }

              ListView {
                id: mediaView

                Layout.fillWidth: true
                Layout.fillHeight: true

                spacing: 24

                model: Mpris.players
                delegate: MprisWidget {
                  required property var modelData
                  player: modelData
                  width: mediaView.width - 64
                  anchors.horizontalCenter: parent.horizontalCenter
                }
              }
            }
          }
        }
      }
    }
  }
}
