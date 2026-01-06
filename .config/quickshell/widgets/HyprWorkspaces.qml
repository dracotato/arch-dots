import QtQuick
import Quickshell
import Quickshell.Hyprland

import qs.services

ListView {
  property string textColor: UI.clrFg
  property real fontSize: UI.txtSize
  property real fontWeight: UI.txtWeight

  width: 180
  height: 32

  orientation: Qt.Horizontal

  Component {
    id: listDelegate
    Rectangle {
      required property real id
      required property real focused
      required property string name

      color: focused ? UI.clrPrimary : "transparent"

      implicitWidth: text.implicitWidth + 12
      anchors.top: parent.top
      anchors.bottom: parent.bottom

      Text {
        id: text

        text: id >= 0 ? id : "SP"
        color: textColor
        font.weight: fontWeight
        font.pixelSize: fontSize
        anchors.centerIn: parent
      }

      MouseArea {
        anchors.fill: parent
        onClicked: { 
          console.log(name)
          if (id >= 0) {
            Hyprland.dispatch(`workspace ${name}`)
          } else {
            Hyprland.dispatch(`togglespecialworkspace ${name.split(':')[1]}`)
          }
        }
      }
    }
  }

  model: Hyprland.workspaces.values
  delegate: listDelegate
}
