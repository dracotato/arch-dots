import QtQuick

import qs.services


Row {
  readonly property string assetsPath: "assets"

  property string textColor: "#eee"
  property real fontSize: 16
  property real fontWeight: 500

  property string icon: updateIcon()
  property string iconColor // updateIcon sets this
  property real iconSize: 18

  function updateIcon() {

    if (Battery.percentage == 100) {
      icon =  Battery.isCharging ? '󰂄' : '󰁹'
    } else if (Battery.percentage >= 90) {
      icon =  Battery.isCharging ? '󰂋' : '󰂂'
    } else if (Battery.percentage >= 80) {
      icon =  Battery.isCharging ? '󰂊' : '󰂁'
    } else if (Battery.percentage >= 70) {
      icon =  Battery.isCharging ? '󰢞' : '󰂀'
    } else if (Battery.percentage >= 60) {
      icon =  Battery.isCharging ? '󰂉' : '󰁿'
    } else if (Battery.percentage >= 50) {
      icon =  Battery.isCharging ? '󰢝' : '󰁾'
    } else if (Battery.percentage >= 40) {
      icon =  Battery.isCharging ? '󰂈' : '󰁽'
    } else if (Battery.percentage >= 30) {
      icon =  Battery.isCharging ? '󰂇' : '󰁼'
    } else if (Battery.percentage >= 20) {
      icon =  Battery.isCharging ? '󰂆' : '󰁻'
    } else if (Battery.percentage >= 10) {
      icon =  Battery.isCharging ? '󰢜' : '󰁺'
    } else if (Battery.percentage < 10) {
      icon =  Battery.isCharging ? '󰢟' : '󰂎'
    }

    if (Battery.percentage < 25) {
      iconColor = "#f22"
    } else {
      iconColor = textColor
    }
  }

  Connections {
    target: Battery
    function onPercentageChanged() {
      updateIcon()
    }
  }

  spacing: 2

  Text {
    id: iconText

    color: iconColor
    font.pixelSize: iconSize
    font.weight: fontWeight

    anchors.verticalCenter: parent.verticalCenter

    text: icon

  }

  Text {
    id: text

    color: textColor
    font.pixelSize: fontSize
    font.weight: fontWeight

    anchors.verticalCenter: parent.verticalCenter

    text: `${Battery.percentage}%`
  }
}
