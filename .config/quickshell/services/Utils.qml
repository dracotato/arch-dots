pragma Singleton

import QtQuick

import Quickshell

Singleton {
  id: root

  function formatDuration(duration) {
    let hours = Math.floor(duration/3600)
    let minutes = Math.floor((duration%3600)/60)
    let seconds = Math.floor(duration%60)

    let h = hours > 0 ? `${hours}\:` : ""
    let m = minutes.toString().padStart(2, "0")
    let s = seconds.toString().padStart(2, "0")
    return `${h}${m}:${s}`
  }
}
