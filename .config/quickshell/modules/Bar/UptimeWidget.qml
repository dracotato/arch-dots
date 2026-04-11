import QtQuick

import Quickshell.Io

import qs.components
import qs.services

IconText {
  id: root

  function uptime() {
    const [d, h, m, s] = Utils.timeParts(System.uptime)

    if (d > 0) {
      return `${d}d ${h}h ${m}m ${s}s`
    }
    else if (h > 0) {
      return `${h}h ${m}m ${s}s`
    } else {
      return `${m}m ${s}s`
    }
  }

  icon: ""
  textContent: `Up ${uptime()}`
}
