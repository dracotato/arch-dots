//@ pragma IconTheme Adwaita
//@ pragma UseQApplication

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls

import qs.modules
import qs.services

ShellRoot {
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

  IpcHandler {
    target: "wallPanel"

    function toggle() {
      AppState.wallPanelVisible = !AppState.wallPanelVisible
    }
  }

  Bar {}

  WallPanel {}
}
