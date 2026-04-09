pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property real uptime
  property real packageUpdates

  Process {
    id: uptimeProc
    running: true
    command: [ "sh", "-c", "uptime --raw" ]
    stdout: StdioCollector {
      onStreamFinished: {
        root.uptime = Number(text.split(" ")[1])
      }
    }
  }

  Process {
    id: updateProc
    running: true
    command: [ "sh", "-c", "checkupdates | wc -l" ]
    stdout: StdioCollector {
      onStreamFinished: {
        root.packageUpdates = Number(text.trim())
      }
    }
  }

  Timer {
    running: true
    interval: 1000
    repeat: true
    onTriggered: uptimeProc.running = true
  }

  Timer {
    running: true
    interval: 10*60000
    repeat: true
    onTriggered: updateProc.running = true
  }
}
