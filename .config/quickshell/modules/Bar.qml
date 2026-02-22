import Quickshell
import Quickshell.Wayland
import QtQuick

import qs.widgets
import qs.services
import qs.components

Scope {
  property bool show
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: panel

      required property var modelData
      screen: modelData
      WlrLayershell.layer: WlrLayer.Top

      implicitHeight: UI.barHeight
      visible: show

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

          MprisWidget {
            id: mpris

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

          Hoverable {
            anchors.verticalCenter: parent.verticalCenter
            parentWindow: panel
            popoutX: rightSection.x + this.x + this.width / 2
            popoutContent: Network.name

            implicitWidth: net.implicitWidth
            implicitHeight: net.implicitHeight

            NetworkWidget {
              id: net

              anchors.verticalCenter: parent.verticalCenter
            }
          }

          KbLayoutWidget {
            anchors.verticalCenter: parent.verticalCenter
          }

          Hoverable {
            anchors.verticalCenter: parent.verticalCenter
            parentWindow: panel
            popoutX: rightSection.x + this.x + this.width / 2
            popoutContent: Brightness.percentage + "%"

            implicitWidth: child.implicitWidth
            implicitHeight: child.implicitHeight

            BrightnessWidget {
              id: child

              anchors.verticalCenter: parent.verticalCenter
            }
          }

          VolumeWidget {
            id: volumeWidget

            anchors.verticalCenter: parent.verticalCenter
            parentWindow: panel
            popoutX: rightSection.x + this.x + this.width / 2
          }
        }
      }
    }
  }
}
