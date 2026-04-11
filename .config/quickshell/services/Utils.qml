pragma Singleton

import QtQuick

import Quickshell

Singleton {
  id: root

  function timeParts(duration) {
    let t = [
      Math.floor(duration/(3600*24)),
      Math.floor((duration%(3600*24))/3600),
      Math.floor((duration%3600)/60),
      Math.floor(duration%60)
    ]

    return t
  }

  function formatDuration(duration) {
    const [days, hours, minutes, seconds] = timeParts(duration)

    let d = days > 0 ? `${days}\:` : ""
    let h = hours > 0 ? `${hours}\:` : ""
    let m = minutes.toString().padStart(2, "0")
    let s = seconds.toString().padStart(2, "0")
    return `${d}${h}${m}:${s}`
  }
}
