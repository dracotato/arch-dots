pragma Singleton

import QtQuick

import Quickshell

Singleton {
  id: root

  property bool barVisible: true
  property bool barFloat: false
  property bool barPopupVisible: false

  property bool wallPanelVisible: false

  property bool settingsVisible: false

  property bool enableFocusUtil: true
}
