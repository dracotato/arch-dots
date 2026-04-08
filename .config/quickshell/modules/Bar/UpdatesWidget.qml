import QtQuick

import Quickshell.Io

import qs.components
import qs.services

IconText {
  id: root

  property real packages: 0

  icon: "󰚰"
  textContent: packages > 0 ? `${packages} Updates` : "Up to date"

  Process {
    id: proc
    running: true
    command: [ "sh", "-c", "checkupdates | wc -l" ]
    stdout: StdioCollector {
      onStreamFinished: {
        root.packages = Number(text.trim())
      }
    }
  }

  Timer {
    running: true
    interval: 10000
    repeat: true
    onTriggered: proc.running = true
  }
}
