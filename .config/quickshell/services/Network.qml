pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  property string name: ""

  Process {
    id: netProc

    command: ["sh", "-c", "nmcli -t -f NAME c show --active | grep -vw 'lo' | head -1"]

    running: true

    stdout: StdioCollector {
      onStreamFinished: root.name = this.text
    }
  }

  Timer {
    interval: 2000

    running: true
    repeat: true

    onTriggered: netProc.running = true
  }
}
