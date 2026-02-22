import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.Mpris

import qs.services

Item {
  id: root

  readonly property real trackMaxLength: 24
  property list<MprisPlayer> list: Mpris.players.values
  property MprisPlayer active: list[0]
  property string statusIcon: active.playbackState == MprisPlaybackState.Playing ? "" : ""

  visible: active

  implicitWidth: col.width + 20
  implicitHeight: col.height + 4

  function formatDuration(duration) {
    return `${Math.floor(duration/60)}:${Math.floor(duration%60).toString().padStart(2, "0")}`
  }

  function updateVolume(value) {
    if (active.canControl && active.volumeSupported) {
      active.volume = Math.max(0, Math.min(active.volume+value, 1))
    } else {
      console.log("Can't update volume")
    }
  }

  FrameAnimation {
    running: active.playbackState == MprisPlaybackState.Playing
    onTriggered: active.positionChanged()
  }

  MouseArea {
    anchors.fill: parent

    onClicked: {
      active.togglePlaying()
    }

    onWheel: (wheel) => {
      updateVolume(wheel.angleDelta.y/500)
    }
  }

  Column {
    id: col

    width: 200
    spacing: 2

    anchors.centerIn: parent

    Row {
      spacing: 8

      anchors.left: parent.left
      anchors.right: parent.right

      Text {
        color: UI.clrFgLt
        font.pixelSize: 12
        font.weight: 500

        text: `${statusIcon} ${active.identity}`
      }

      Text {
        property string textColor: UI.clrFgLt
        property real fontSize: 12
        property real fontWeight: 500

        color: UI.clrFgLt
        font.pixelSize: 12
        font.weight: 500

        text: `󰕾 ${Math.floor(active.volume*100)}%`
      }

      Text {
        property real playerNum: Mpris.players.values.length - 1

        color: UI.clrFgLt
        font.pixelSize: 12
        font.weight: 500

        text: playerNum > 0 ? `+${playerNum} other player${playerNum > 1 ? "s" : ""}` : ""
      }
    }

    RowLayout {
      spacing: 12

      anchors.left: parent.left
      anchors.right: parent.right

      Text {
        color: UI.clrFg
        font.pixelSize: 14
        font.weight: 500
        clip: true

        Layout.fillWidth: true

        text: active.trackTitle || "Unknown"
      }

      Text {
        color: UI.clrFgLt
        font.pixelSize: 14
        font.weight: 500

        text: `${formatDuration(active.position)} — ${formatDuration(active.length)}`
      }
    }

    ProgressBar {
      id: progressBar

      to: active.length
      value: active.position
      indeterminate: active.trackTitle ? false : true

      anchors.left: parent.left
      anchors.right: parent.right

      background: Rectangle {
        implicitHeight: 2
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
