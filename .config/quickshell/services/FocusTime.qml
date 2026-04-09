pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

import qs.services

Singleton {
  id: root

  property real focusDuration: 45*60
  property real breakDuration: 5*60
  property real timeSpent: 0
  property real percentage: 0
  property string mode: "focus" // "focus" or "break"

  property bool paused: false

  function nextMode(m) {
    setMode(mode == "focus" ? "break" : "focus")
  }

  function setMode(m) {
    timeSpent = 0
    mode = m
  }

  function togglePause() {
    paused = !paused
    Osd.showOsd(paused ? "" : "", `Focus ${paused ? "paused" : "continued"}`)
  }

  Timer {
    id: timer

    interval: 1000

    running: AppState.enableFocusUtil && !paused
    repeat: true

    onTriggered: {
      timeSpent += 1
      switch (mode) {
        case "focus":
          percentage = timeSpent / focusDuration
          if (timeSpent == focusDuration) {
            setMode("break")
          }
          break;
        case "break":
          percentage = timeSpent / breakDuration
          if (timeSpent == breakDuration) {
            setMode("focus")
          }
          break;
        default:
          console.error("Unexpected mode:", mode)
      }
    }
  }

  IpcHandler {
    target: "focusUtil"

    function toggle() {
      AppState.enableFocusUtil = !AppState.enableFocusUtil
    }
  }
}
