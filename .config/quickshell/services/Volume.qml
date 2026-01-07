pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
  id: root

  property real rawPercentage
  property real percentage: Math.trunc(rawPercentage*100)
  property bool muted: false
  property bool micMuted: false

  Process {
    id: initProc
    running: true
    command: [ "sh", "-c", "wpctl get-volume @DEFAULT_SINK@" ]
    stdout: StdioCollector {
      onStreamFinished: root.rawPercentage = text.split(" ")[1]
    }
  }

  Process {
    id: setProc
    stderr: StdioCollector {
      onStreamFinished: {
        if (text) {
          console.error(`Set volume command failed. See below:\n>> ${text.trim()}\n>> Command Ran: ${setProc.command}`)
        }
      }
    }
  }

  function setMute(value) {
    setProc.command = ["wpctl", "set-mute", "@DEFAULT_SINK@", value ? 1 : 0]
    setProc.running = true
    root.muted = value
  }

  function setMicMute(value) {
    setProc.command = ["wpctl", "set-mute", "@DEFAULT_SOURCE@", value ? 1 : 0]
    setProc.running = true
    root.micMuted = value
  }

  function setVolume(value) {
    let limit = 1.2
    if (muted) {
      setMute(false)
    }

    root.rawPercentage = Math.max(0, Math.min(value/100, limit))
    setProc.command = ["wpctl", "set-volume", "@DEFAULT_SINK@", `${root.percentage}%`, "-l", limit]
    setProc.running = true
  }

  GlobalShortcut {
    name: "incrementVolume"
    description: "Increment volume"
    onPressed: setVolume(percentage+4)
  }

  GlobalShortcut {
    name: "decrementVolume"
    description: "Decrement volume"
    onPressed: setVolume(percentage-4)
  }

  GlobalShortcut {
    name: "toggleMute"
    description: "Toggle volume mute"
    onPressed: {
      setMute(!root.muted)
    }
  }

  GlobalShortcut {
    name: "toggleMicMute"
    description: "Toggle microphone"
    onPressed: {
      setMicMute(!root.micMuted)
    }
  }
}
