import QtQuick
import QtQuick.Layouts

import Quickshell

import qs.services
import qs.components

Item {
  id: root

  required property var notif
  required property real idx

  property real padding: 12

  property bool paused: false
  property bool alive: life > 0
  property real totalLife: 10*1000 // ms
  property real life: totalLife

  property real slideDuration: 300

  width: UI.notifWidth
  height: main.implicitHeight + padding*2

  onAliveChanged: {
    if (!alive) {
      x = width
    }
  }

  Behavior on x {
    NumberAnimation {
      duration: slideDuration
      easing.type: Easing.InOutQuad
    }
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true

    onEntered: {
      root.paused = true
      console.log("paused", paused)
    }
    onExited: {
      root.paused = false
      console.log("unpaused", paused)
    }
    onClicked: {
      console.log("actions", notif.n.actions)
      if (notif.n.actions.length > 0) notif.n.actions[0].invoke()
    }
  }

  Timer {
    id: lifeTimer

    running: alive
    repeat: true
    interval: 10
    onTriggered: {
      if (root.paused) return;
      life -= lifeTimer.interval
    }
  }

  Timer {
    id: deathTimer

    running: !alive
    interval: slideDuration
    onTriggered: {
      notif.n?.dismiss()
      Notifs.list.remove(idx)
    }
  }

  Rectangle {
    anchors.fill: parent
    color: UI.clrBg
    opacity: .8
  }

  Rectangle {
    anchors.top: parent.top
    anchors.left: parent.left

    width: parent.width * (life/totalLife)
    height: 2
    color: UI.clrPrimary
  }

  RowLayout {
    id: main

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.margins: root.padding

    width: root.width - root.padding*2
    spacing: 16

    Item {
      id: imgContainer

      Layout.alignment: Qt.AlignTop
      Layout.preferredWidth: 48
      Layout.preferredHeight: 48

      Image {
        id: img

        anchors.fill: parent
        source: root.notif.n.image
        visible: {
          return root.notif.image.length > 0
        }
      }

      Image {
        id: appImg

        width: {
          return img.visible ? parent.width/2 : parent.width
        }
        height: width

        anchors.right: imgContainer.right
        anchors.bottom: imgContainer.bottom
        anchors.margins: img.visible ? -4 : 0

        source: root.notif.appIcon.includes("/") ?
        `file://${root.notif.appIcon}` :
        Quickshell.iconPath(DesktopEntries.heuristicLookup(root.notif.appIcon)?.icon)
        visible: {
          return root.notif.appIcon.length > 0
        }
      }
    }

    ColumnLayout {
      id: col

      spacing: 8

      Text {
        id: summary

        Layout.fillWidth: true

        text: root.notif.summary
        font.weight: 700
        wrapMode: Text.WordWrap
      }

      Text {
        id: body

        Layout.fillWidth: true

        text: root.notif.body
        color: UI.clrFgLt
        wrapMode: Text.Wrap
      }
    }
  }
}
