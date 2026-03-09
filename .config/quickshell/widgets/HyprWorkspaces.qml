import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Hyprland

import qs.components
import qs.services

ListView {
  required property string screen

  orientation: Qt.Horizontal
  spacing: 8

  function replaceName(name) {
    const icons = {
      "browser": "",
      "docs": "󱔗",
      "notes": "󰠮",
      "side-utils": "",
      "music": "",
      "social": "",
      "code": "",
      "term": "",
      "design": "",
      "games": "",
      "video-edit": "󰨜",
    }

    return icons[name] || (isNaN(Number(name)) ? name : Number(name) % 10)
  }

  Component {
    id: listDelegate

    Item {
      id: root

      required property var modelData
      property real windowsNum: modelData.toplevels.values.length
      property string bgColor: modelData.focused ? UI.clrPrimary : "transparent"
      property string textColor: windowsNum > 0 ? UI.clrFg : UI.clrFgLt

      anchors.top: parent.top
      anchors.bottom: parent.bottom

      width: row.width + 16

      Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        height: modelData.focused ? parent.height : 4

        Behavior on height {
          NumberAnimation { duration: 150; easing.type: Easing.InOutQuad }
        }

        color: (windowsNum > 0 || modelData.focused) ? UI.clrPrimary : "transparent"
      }

      RowLayout {
        id: row

        anchors.centerIn: parent

        spacing: 4

        Text {
          color: textColor
          text: replaceName(modelData.name)
        }

        Text {
          color: textColor

          font.pixelSize: 10
          font.weight: 700

          text: `(${modelData.id})`
        }
      }

      MouseArea {
        anchors.fill: parent
        onClicked: { 
          if (modelData.id >= 0) {
            Hyprland.dispatch(`workspace ${modelData.id}`)
          } else {
            Hyprland.dispatch(`togglespecialworkspace ${modelData.name.split(':')[1]}`)
          }
        }
      }
    }
  }

  model: Hyprland.workspaces.values.filter((workspace) => workspace.monitor?.name == screen)
  delegate: listDelegate
}
