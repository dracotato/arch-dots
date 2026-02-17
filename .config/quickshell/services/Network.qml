pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  property string name
  property string status
  property real strength

  Process {
    id: netProc

    // get connected network type and name, exclude loopback devices
    command: ["sh", "-c", "nmcli -t -f TYPE,NAME con show --active | grep -v '^loopback:' | head -1"]

    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        root.status = text ? text.split(":")[0] : ""
        root.name = text ? text.split(":")[1] : ""
        const len = root.name.length
      }
    }
  }

  Process {
    id: sigProc
    running: true
    command: [ "sh", "-c", "nmcli -t -f IN-USE,SIGNAL dev wifi list | grep '^*'" ]
    stdout: StdioCollector {
      onStreamFinished: root.strength = text.split(":")[1]
    }
  }

  Timer {
    interval: 5000

    running: true
    repeat: true

    onTriggered: {
      netProc.running = true
      sigProc.running = true
    }
  }
}
