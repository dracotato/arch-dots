pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

Singleton {
  id: root

  signal osd(string icon, string text)

  function showOsd(icon, text) {
    root.osd(icon, text)
  }

  IpcHandler {
    target: "osd"

    function show(icon: string, text: string) {
      root.osd(icon, text)
    }
  }
}
