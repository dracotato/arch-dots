import QtQuick

import Quickshell.Io

import qs.components
import qs.services

IconText {
  id: root

  icon: ""
  textContent: `Up ${Utils.formatDuration(System.uptime)}`
}
