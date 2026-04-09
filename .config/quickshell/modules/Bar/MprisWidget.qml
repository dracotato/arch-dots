import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.Mpris

import qs.components
import qs.services

Item {
  id: root

  property list<MprisPlayer> players: Mpris.players.values
  property real activeIndex: 0
  property MprisPlayer active: players[activeIndex]
  property bool isPlaying: active?.playbackState == MprisPlaybackState.Playing

  property string activeIdentity: active?.identity ?? ""
  property real activeVolume: (active?.volume ?? 1)*100
  property string activeTrack: active?.trackTitle ?? "Nothing is playing"
  property string activeAuthor: active?.trackAuthor ?? "Unknown"

  width: 400
  height: 200

  function updateVolume(value) {
    if (active?.canControl && active?.volumeSupported) {
      active.volume = Math.max(0, Math.min(active.volume+value, 1))
    }
  }

  function updatePlayer(dir) {
    if (players.length <= 1) {
      return
    }

    if (dir > 0) {
      activeIndex = (activeIndex == players.length - 1 ? 0 : activeIndex + 1);
    } else {
      activeIndex = (activeIndex == 0 ? players.length - 1 : activeIndex - 1);
    }
  }

  FrameAnimation {
    running: isPlaying
    onTriggered: active?.positionChanged()
  }

  Rectangle {
    id: main

    anchors.fill: parent

    radius: 8
    color: isPlaying ? UI.clrPrimary : UI.clrBgLt

    Behavior on color {
      ColorAnimation { duration: 400; easing.type: Easing.InOutQuad }
    }

    RowLayout {
      anchors.fill: parent
      anchors.margins: 16
      spacing: 8

      BasicButton {
        text: "🢐"
        txtColor: UI.clrPrimaryLt
        hoverTxtColor: UI.clrFg
        txtSize: UI.iconSizeBig

        onClicked: updatePlayer(-1)
      }

      ColumnLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true

        spacing: 8

        RowLayout {
          Layout.fillWidth: true

          Column {
            spacing: -2

            Image {
              visible: activeIdentity
              source: Quickshell.iconPath(DesktopEntries.heuristicLookup(activeIdentity)?.icon)
              sourceSize.width: UI.iconSize
              sourceSize.height: UI.iconSize
            }

            Text {
              anchors.horizontalCenter: parent.horizontalCenter

              text: activeIdentity
              color: UI.clrFgLt
              font.pixelSize: UI.txtSizeSmall
              font.weight: UI.txtWeightBold
            }
          }

          // empty gap
          Item {
            Layout.fillWidth: true
          }


          MouseArea {
            width: col.width
            height: col.height

            onClicked: {
              active?.togglePlaying()
            }

            onWheel: (wheel) => {
              updateVolume(wheel.angleDelta.y/2400)
            }

            Column {
              id: col

              // necessary to prevent layout shifts when percentage goes from 100 to 99
              width: 30

              spacing: -4

              Text {
                anchors.horizontalCenter: parent.horizontalCenter

                text: "󰕾"
                color: UI.clrFgLt
                font.pixelSize: UI.iconSizeBig
              }

              Text {
                anchors.horizontalCenter: parent.horizontalCenter

                text: Math.floor(activeVolume) + "%"
                font.pixelSize: UI.txtSizeSmall
                color: UI.clrFgLt
                font.weight: UI.txtWeightBold
              }
            }
          }
        }

        Column {
          Layout.fillWidth: true
          Layout.fillHeight: true

          spacing: 2
          clip: true

          Text {
            text: activeTrack
            font.weight: 700
          }

          Text {
            text: `By: ${activeAuthor}`
            color: UI.clrFgLt
            font.pixelSize: UI.txtSizeSmall
          }
        }

        Column {
          Layout.fillWidth: true
          Layout.alignment: Qt.AlignHCenter

          spacing: 12

          ProgressBar {
            id: progressBar

            anchors.left: parent.left
            anchors.right: parent.right

            to: active?.length ?? 1
            value: active?.position ?? 0

            background: Rectangle {
              implicitHeight: 4
              color: UI.clrBg
              radius: 4
            }

            contentItem: Item {
              Rectangle {
                width: progressBar.visualPosition * parent.width
                height: parent.height
                radius: 4
                color: UI.clrPrimaryLt
              }
            }
          }

          Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 16

            BasicButton {
              text: "󰒮"
              txtColor: UI.clrPrimaryLt
              hoverTxtColor: UI.clrFg
              txtSize: UI.iconSizeBig

              onClicked: {
                if (active?.canGoPrevious) {
                  active?.previous()
                }
              }
            }

            BasicButton {
              text: isPlaying ? "" : ""
              txtColor: UI.clrPrimaryLt
              hoverTxtColor: UI.clrFg
              txtSize: UI.iconSizeBig

              onClicked: {
                if (active?.canPause) {
                  active?.togglePlaying()
                }
              }
            }

            BasicButton {
              text: "󰒭"
              txtColor: UI.clrPrimaryLt
              hoverTxtColor: UI.clrFg
              txtSize: UI.iconSizeBig
              onClicked: {
                if (active?.canGoNext) {
                  active?.next()
                }
              }
            }
          }
        }
      }

      BasicButton {
        text: "🢒"
        txtColor: UI.clrPrimaryLt
        hoverTxtColor: UI.clrFg
        txtSize: UI.iconSizeBig

        onClicked: updatePlayer(1)
      }
    }
  }
}
