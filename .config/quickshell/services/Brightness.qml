pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
  id: root

  property int percentage

  Process {
    id: initProc
    running: true
    command: [ "sh", "-c", "brightnessctl -m" ]
    stdout: StdioCollector {
      onStreamFinished: {
        let readPercentage = text.split(",")[3]
        readPercentage = readPercentage.substring(0, readPercentage.length-1) // remove the "%"
        root.percentage = readPercentage
      }
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
