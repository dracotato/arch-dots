pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

Singleton {
  id: root
  property string name
  property string status
  property real strength
  property string icon

  function updateIcon() {
    if (status && Network.status != "802-11-wireless") {
      icon = ""
      return
    }

    // not connected
    if (!name) {
      icon = "󰤮"
      return
    }

    if (strength > 80) {
      icon = "󰤨"
    } else if (strength > 60) {
      icon = "󰤥"
    } else if (strength > 40) {
      icon = "󰤢"
    } else if (strength > 20) {
      icon = "󰤟"
    } else {
      icon = "󰤯"
    }
  }

  Process {
    id: netProc

    // get connected network type and name, exclude loopback devices
    command: ["sh", "-c", "nmcli -t -f TYPE,NAME con show --active | grep -v '^loopback:' | head -1"]

    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        root.status = text ? text.split(":")[0] : ""
        root.name = text ? text.split(":")[1].trim() : ""
        updateIcon()
      }
    }
  }

  Process {
    id: sigProc
    running: true
    command: [ "sh", "-c", "nmcli -t -f IN-USE,SIGNAL dev wifi list | grep '^*'" ]
    stdout: StdioCollector {
      onStreamFinished: {
        root.strength = text.split(":")[1] | 0
      }
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
