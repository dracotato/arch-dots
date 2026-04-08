import QtQuick

import qs.services
import qs.components


IconText {

  textContent: Network.name ? (Network.name.length > 7 ? Network.name.substring(0, 5) + "…" : Network.name) : ""
  icon: Network.icon
}
