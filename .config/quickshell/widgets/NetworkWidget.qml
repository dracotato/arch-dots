import QtQuick

import qs.services
import qs.components


IconText {

  textContent: Network.name ? (Network.name.length > 7 ? Network.name.substring(0, 5) + "…" : Network.name) : "N/A"
  icon: updateIcon(Network.status, Network.strength)

  function updateIcon(status, strength) {
    if (status && status != "802-11-wireless") {
      icon = ""
      return
    }

    if (!strength) {
      icon = "󰤮"
      return
    }

    if (strength >= 80) {
      icon = "󰤨"
    } else if (strength >= 60) {
      icon = "󰤥"
    } else if (strength >= 40) {
      icon = "󰤢"
    } else if (strength >= 20) {
      icon = "󰤟"
    } else {
      icon = "󰤯"
    }
  }

  Connections {
    target: Network
    function onStrengthChanged() {
      updateIcon(Network.status, Network.strength)
    }
  }

}
