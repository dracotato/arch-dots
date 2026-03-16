pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire

import qs.services

Singleton {
  id: root

  readonly property var defaultSink: Pipewire.defaultAudioSink

  PwObjectTracker {
    objects: [ defaultSink ]
  }

  property real rawPercentage: defaultSink?.audio.volume
  property real percentage: Math.floor(rawPercentage*100)

  property bool muted: defaultSink?.audio.muted

  property bool initialRead: false

  Connections {
    target: defaultSink?.audio

    function onVolumeChanged() {
      rawPercentage = defaultSink.audio.volume
      // prevent showing osd on startup when volume didn't actually change,
      // but is just read for the first time
      if (initialRead) {
        Osd.showOsd("󰕾", `Volume ${percentage}%`)
      } else {
        initialRead = true
      }
    }

    function onMutedChanged() {
      muted = defaultSink.audio.muted
      Osd.showOsd(muted ? "󰝟" : "󰕾", muted ? "Muted" : "Unmute")
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
