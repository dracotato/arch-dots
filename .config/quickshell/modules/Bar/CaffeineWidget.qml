import QtQuick

import Quickshell.Io

import qs.components
import qs.services

Rectangle {
  property bool active
  property string idleManager: "hypridle"
  property string startupCmd: "hyprctl dispatch exec hypridle"

  width: 32
  height: width

  color: active ? UI.clrPrimary : UI.clrBgLt
  radius: 999


  Behavior on color {
    ColorAnimation { duration: 100 }
  }

  MouseArea {
    anchors.fill: parent

    onClicked: {
      toggle()
    }
  }

  Text {
    id: icon

    anchors.centerIn: parent

    text: active ? "󰅶" : "󰾪"
  }

  Process {
    id: getProc

    running: true
    command: [ "sh", "-c", `pgrep ${idleManager}` ]
    stdout: StdioCollector {
      onStreamFinished: {
        // no text, then idleManager is running (non-caffeine)
        active = text ? false : true
      }
    }
  }

  function toggle() {
    let cmd = ["sh", "-c"]
    cmd.push(active ? startupCmd : `killall ${idleManager}`)

    setProc.command = cmd
    setProc.running = true
  }

  Process {
    id: setProc
    onRunningChanged: {
      if (!running) {
        // run the getProc after a set operation
        getProc.running = true
      }
    }
  }
}
