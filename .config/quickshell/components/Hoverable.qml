import QtQuick

import Quickshell

import qs.services

Item {
  id: root

  required property var parentWindow
  required property real popoutX
  required property string popoutContent

  property real popoutWidth: 300
  property real popoutHeight: 50

  property bool cursorInside: false
  property bool hover: false
  property real angleDelta

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true

    onWheel: (scroll) => {
      root.angleDelta = scroll.angleDelta
    }
    onEntered: {
      hoverDelay.running = true
      cursorInside = true
    }
    onExited: {
      cursorInside = false
      hover = false
    }
  }

  Timer {
    id: hoverDelay

    interval: 300
    onTriggered: {
      if (cursorInside) {
        hover = true
      }
    }
  }

  PopupWindow {
    anchor.window: root.parentWindow
    anchor.rect.x: root.popoutX - this.width / 2
    anchor.rect.y: root.parentWindow.height

    visible: root.hover

    color: "transparent"

    implicitWidth: text.implicitWidth + 16
    implicitHeight: text.implicitHeight + 16

    Rectangle {
      color: UI.clrBg
      anchors.fill: parent

      bottomLeftRadius: 8
      bottomRightRadius: 8

      Text {
        id: text

        text: popoutContent
        color: UI.clrFg
        anchors.centerIn: parent
      }
    }
  }
}
