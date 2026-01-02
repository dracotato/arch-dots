pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
  id: root
  property string layout
  property string layoutAbbr

  function setLayout(layout) {
    root.layout = layout;
    root.layoutAbbr = layout.substring(0, 2).toUpperCase();
  }

  Process {
    id: proc
    running: true
    command: [ "sh", "-c", "hyprctl -j devices | jq -j '.[][] | select(.main == true) | .active_keymap'" ]
    stdout: StdioCollector {
      onStreamFinished: {
        setLayout(this.text);
      }
    }
  }

  Connections {
    target: Hyprland
    function onRawEvent(event) {
      if (event.name === "activelayout") {
        const layout = event.parse(2)[1]
        setLayout(layout)
      }
    }
  }
}
