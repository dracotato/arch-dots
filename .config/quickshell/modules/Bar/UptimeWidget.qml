import QtQuick

import Quickshell.Io

import qs.components
import qs.services

IconText {
  id: root

  icon: ""
  textContent: ""

  Process {
    id: proc
    running: true
    command: [ "sh", "-c", "uptime --pretty" ]
    stdout: StdioCollector {
      onStreamFinished: {
        const trimmed = text.trim()
        root.textContent = trimmed[0].toUpperCase() + trimmed.substr(1)
      }
    }
  }

  Timer {
    running: true
    interval: 1000
    repeat: true
    onTriggered: proc.running = true
  }
}
