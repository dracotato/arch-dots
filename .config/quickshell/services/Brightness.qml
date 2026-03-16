pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

import qs.services

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
    command: ["brightnessctl", "set", `${root.percentage}%`]
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
    setProc.running = true

    Osd.showOsd("󰃠", `Brightness ${percentage}%`)
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
