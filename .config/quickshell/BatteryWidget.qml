import QtQuick

import qs.services


IconText {
  textContent: `${Battery.percentage}%`
  icon: updateIcon()

  function updateIcon() {
    if (Battery.percentage == 100) {
      icon = Battery.isCharging ? '󰂄' : '󰁹'
    } else if (Battery.percentage >= 90) {
      icon = Battery.isCharging ? '󰂋' : '󰂂'
    } else if (Battery.percentage >= 80) {
      icon = Battery.isCharging ? '󰂊' : '󰂁'
    } else if (Battery.percentage >= 70) {
      icon = Battery.isCharging ? '󰢞' : '󰂀'
    } else if (Battery.percentage >= 60) {
      icon = Battery.isCharging ? '󰂉' : '󰁿'
    } else if (Battery.percentage >= 50) {
      icon = Battery.isCharging ? '󰢝' : '󰁾'
    } else if (Battery.percentage >= 40) {
      icon = Battery.isCharging ? '󰂈' : '󰁽'
    } else if (Battery.percentage >= 30) {
      icon = Battery.isCharging ? '󰂇' : '󰁼'
    } else if (Battery.percentage >= 20) {
      icon = Battery.isCharging ? '󰂆' : '󰁻'
    } else if (Battery.percentage >= 10) {
      icon = Battery.isCharging ? '󰢜' : '󰁺'
    } else if (Battery.percentage < 10) {
      icon = Battery.isCharging ? '󰢟' : '󰂎'
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
}
