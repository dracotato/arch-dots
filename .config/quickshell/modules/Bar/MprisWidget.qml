import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.Mpris

import qs.components
import qs.services

Item {
  id: root

  required property MprisPlayer player

  property string statusIcon: player.playbackState == MprisPlaybackState.Playing ? "" : ""

  width: 200
  height: col.height

  function formatDuration(duration) {
    return `${Math.floor(duration/60)}:${Math.floor(duration%60).toString().padStart(2, "0")}`
  }

  function updateVolume(value) {
    if (player.canControl && player.volumeSupported) {
      player.volume = Math.max(0, Math.min(player.volume+value, 1))
    } else {
      console.log("Can't update volume")
    }
  }

  FrameAnimation {
    running: player.playbackState == MprisPlaybackState.Playing
    onTriggered: player.positionChanged()
  }

  MouseArea {
    anchors.fill: parent

    onClicked: {
      player.togglePlaying()
    }

    onWheel: (wheel) => {
      updateVolume(wheel.angleDelta.y/2400)
    }
  }

  Column {
    id: col

    anchors.left: parent.left
    anchors.right: parent.right

    spacing: 4

    RowLayout {
      spacing: 8

      anchors.left: parent.left

      Image {
        source: Quickshell.iconPath(DesktopEntries.heuristicLookup(player.identity).icon)
        sourceSize.width: 16
        sourceSize.height: 16
      }

      Text {
        color: UI.clrFgLt
        font.pixelSize: 12

        text: DesktopEntries.heuristicLookup(player.identity)?.icon || `N/A (${player.identity})`
      }

      Text {
        color: UI.clrFgLt
        font.pixelSize: 12

        text: `󰕾 ${Math.floor(player.volume*100)}%`
      }
    }

    RowLayout {
      spacing: 12

      anchors.left: parent.left
      anchors.right: parent.right

      Text {
        font.pixelSize: 14

        Layout.fillWidth: true
        clip: true

        text: player.trackTitle || "Unknown"
      }

      Text {
        color: UI.clrFgLt
        font.pixelSize: 14

        text: `${formatDuration(player.position)} — ${formatDuration(player.length)}`
      }
    }

    ProgressBar {
      id: progressBar

      to: player.length
      value: player.position
      indeterminate: player.trackTitle ? false : true

      anchors.left: parent.left
      anchors.right: parent.right

      background: Rectangle {
        implicitHeight: 4
        color: UI.clrBgLt
        radius: 4
      }

      contentItem: Item {
        implicitHeight: 1

        Rectangle {
          width: progressBar.visualPosition * parent.width
          height: parent.height
          radius: 4
          color: UI.clrPrimary
          visible: !progressBar.indinate
        }

        Item {
          anchors.fill: parent
          visible: progressBar.indeterminate
          clip: true

          Rectangle {
            id: indRect

            property real animDuration: 5000

            color: UI.clrPrimary
            width: 20
            height: progressBar.height

            SequentialAnimation on x {
              running: true
              loops: Animation.Infinite
              NumberAnimation { to: progressBar.width - indRect.width; duration: indRect.animDuration/2; easing.type: Easing.InOutQuad }
              NumberAnimation { to: 0; duration: indRect.animDuration/2; easing.type: Easing.InOutQuad }
            }
          }
        }
      }
    }
  }
}
