import QtQuick

import Quickshell
import Quickshell.Io
import Quickshell.Wayland

import qs.services
import qs.components

PanelWindow {
  id: root

  visible: AppState.settingsVisible
  focusable: true
  color: "transparent"

  WlrLayershell.layer: WlrLayer.Overlay
  anchors {
    top: true
    right: true
    bottom: true
    left: true
  }

  Item {
    focus: AppState.settingsVisible
    Keys.onPressed: (event) => {
      if (event.key == Qt.Key_Escape && AppState.settingsVisible) {
        event.accepted = true;
        AppState.settingsVisible = false;
      }
    }
  }

  Rectangle {
    anchors.centerIn: parent

    width: main.width + 16
    height: main.height + 16
    color: UI.clrBg
    radius: 32

    Column {
      id: main

      anchors.centerIn: parent

      ToggleButton {
        text: "Bar float mode"
        value: AppState.barFloat
        onValueChanged: {
          AppState.barFloat = value
        }
      }
    }
  }

  IpcHandler {
    target: "settingsPanel"

    function toggle() {
      AppState.settingsVisible = !AppState.settingsVisible
    }
  }
}
