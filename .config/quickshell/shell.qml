import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls

import qs.modules

ShellRoot {
  property bool barVisible: true
  property bool wallPanelVisible: false


  IpcHandler {
    target: "bar"

    function toggle() {
      barVisible = !barVisible
    }
  }

  IpcHandler {
    target: "wallPanel"

    function toggle() {
      wallPanelVisible = !wallPanelVisible
    }
  }

  Bar {
    show: barVisible
  }

  WallPanel {
    show: wallPanelVisible
  }
}
