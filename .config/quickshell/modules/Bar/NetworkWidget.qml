import QtQuick

import qs.services
import qs.components


IconText {

  textContent: Network.name ? (Network.name.length > 7 ? Network.name.substring(0, 5) + "…" : Network.name) : ""
  icon: updateIcon()

  function updateIcon() {
    if (Network.status && Network.status != "802-11-wireless") {
      icon = ""
      return
    }

    // not connected
    if (!Network.name) {
      icon = "󰤮"
      return
    }

    if (Network.strength >= 80) {
      icon = "󰤨"
    } else if (Network.strength >= 60) {
      icon = "󰤥"
    } else if (Network.strength >= 40) {
      icon = "󰤢"
    } else if (Network.strength >= 20) {
      icon = "󰤟"
    } else {
      icon = "󰤯"
    }
  }

  Connections {
    target: Network
    function onStrengthChanged() {
      updateIcon()
    }
  }
}
