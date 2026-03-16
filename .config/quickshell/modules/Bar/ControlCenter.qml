import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.SystemTray

import qs.services
import qs.components

PopupWindow {
  id: popupWindow

  required property var panel
  required property var screen

  property real animDuration: 400
  property bool trayEmpty: SystemTray.items.values.length == 0
  property bool isAnimating: false

  anchor.window: panel
  anchor.rect.x: panel.width / 2 - this.width / 2
  anchor.rect.y: panel.height

  color: "transparent"

  visible: isAnimating || AppState.barPopupVisible

  implicitWidth: screen.width * .4
  implicitHeight: popoutRect.height

  Rectangle {
    id: popoutRect

    y: (AppState.barPopupVisible && screen.name == Hyprland.focusedMonitor.name) ? 0 : -height

    Connections {
      target: AppState

      function onBarPopupVisibleChanged() {
        isAnimating = true
        animTimer.running = true
      }
    }

    Behavior on y {
      NumberAnimation { duration: animDuration; easing.type: Easing.InOutQuad }
    }

    width: parent.width
    height: popoutContent.height + 48
    color: UI.clrBg

    bottomLeftRadius: 8
    bottomRightRadius: 8

    Timer {
      id: animTimer

      // after the slide-in/out animation ends
      interval: animDuration
      onTriggered: {
        // make sure the animation is actually finished
        if (popoutRect.y == -popoutRect.height) {
          popupWindow.isAnimating = false
        }
      }
    }

    ColumnLayout {
      id: popoutContent


      anchors.top: parent.top
      anchors.topMargin: 24
      anchors.bottomMargin: 24
      anchors.horizontalCenter: parent.horizontalCenter

      width: parent.width - 24*2

      spacing: 24

      MprisWidget {
        Layout.fillWidth: true
      }

      Rectangle {
        Layout.fillWidth: true

        height: 2
        visible: !trayEmpty

        color: UI.clrBgLt
      }

      Loader {
        Layout.fillWidth: true

        active: !trayEmpty
        visible: active // to avoid reserving space

        sourceComponent: trayView
      }

      Component {
        id: trayView

        ListView {
          id: sysTray

          height: 24

          orientation: Qt.Horizontal
          spacing: 16

          model: SystemTray.items
          delegate: Image {
            id: trayItem

            required property var modelData

            height: sysTray.height
            width: height

            source: modelData.icon

            QsMenuAnchor {
              id: trayMenu

              anchor {
                item: trayItem
                edges: Edges.Bottom | Edges.Right
              }
              menu: modelData.menu
            }

            MouseArea {
              anchors.fill: parent

              acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton

              onClicked: (event) => {
                switch (event.button) {
                  case Qt.LeftButton:
                    modelData.activate()
                    break;
                  case Qt.MiddleButton:
                    modelData.secondaryActivate()
                    break;
                  case Qt.RightButton:
                    if (trayMenu.visible) {
                      trayMenu.close()
                    } else {
                      trayMenu.open()
                    }
                    break;
                }
              }
            }
          }
        }
      }
    }
  }
}
