pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire

Singleton {
  id: root

  readonly property var defaultSink: Pipewire.defaultAudioSink

  PwObjectTracker {
    objects: [ defaultSink ]
  }

  property real rawPercentage: defaultSink?.audio.volume

  property bool muted: defaultSink?.audio.muted

  Connections {
    target: defaultSink?.audio

    function onVolumeChanged() {
      rawPercentage = defaultSink.audio.volume
    }

    function onMutedChanged() {
      muted = defaultSink.audio.muted
    }
  }

  function setMute(value) {
    defaultSink.audio.muted = value
  }

  function setVolume(value) {
    let limit = 1.2

    if (muted) {
      defaultSink.audio.muted = false
    }

    defaultSink.audio.volume = Math.min(value, limit)
  }

  GlobalShortcut {
    name: "incrementVolume"
    description: "Increment volume"
    onPressed: setVolume(rawPercentage+.04)
  }

  GlobalShortcut {
    name: "decrementVolume"
    description: "Decrement volume"
    onPressed: setVolume(rawPercentage-.04)
  }

  GlobalShortcut {
    name: "toggleMute"
    description: "Toggle volume mute"
    onPressed: {
      setMute(!root.muted)
    }
  }
}
