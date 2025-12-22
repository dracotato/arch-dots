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
        root.status = this.text ? this.text.split(":")[0] : ""
        root.name = this.text ? this.text.split(":")[1] : ""
      }
    }
  }

  Process {
    id: sigProc
    running: true
    command: [ "sh", "-c", "nmcli -t -f IN-USE,SIGNAL dev wifi list | grep '^*' | awk -F ':' '{print $2}'" ]
    stdout: StdioCollector {
      onStreamFinished: root.strength = this.text
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
