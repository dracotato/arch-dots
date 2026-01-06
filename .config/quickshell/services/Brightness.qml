pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
  id: root

  property real rawPercentage: percentage/100
  property int percentage

  Process {
    id: initProc
    running: true
    command: [ "sh", "-c", "brightnessctl -m | awk -F, '{ print $4 }'" ]
    stdout: StdioCollector {
      onStreamFinished: root.percentage = text.substring(0, text.length-2)
    }
  }

  Process {
    id: setProc
    stderr: StdioCollector {
      onStreamFinished: {
        if (text) {
          console.error(`Set brightness command failed. See below:\n>> ${text.trim()}\n>> Command Ran: ${setProc.command}`)
        }
      }
    }
  }

  function setBrightness(value) {
    root.percentage = Math.max(0, Math.min(value, 100))
    setProc.command = ["brightnessctl", "set", `${root.percentage}%`]
    setProc.running = true
  }

  GlobalShortcut {
    name: "incrementBrightness"
    description: "Increment brightness"
    onPressed: setBrightness(percentage+4)
  }

  GlobalShortcut {
    name: "decrementBrightness"
    description: "Decrement brightness"
    onPressed: setBrightness(percentage-4)
  }
}
