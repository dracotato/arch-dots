import QtQuick

import Quickshell
import Quickshell.Wayland

import qs.services


PanelWindow {
  id: panel

  WlrLayershell.layer: WlrLayer.Overlay
  exclusionMode: ExclusionMode.ignore

  color: "transparent"
  visible: AppState.barVisible

  margins {
    right: UI.osdScreenPad
    left: UI.osdScreenPad
    bottom: UI.osdScreenPad
  }

  anchors {
    right: true
    bottom: true
    left: true
  }

  Rectangle {
    width: 200
    height: 48
  }
}
