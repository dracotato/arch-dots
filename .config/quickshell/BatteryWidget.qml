import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

RowLayout {
  readonly property Text text: text
  property string color: {
    if (Battery.percentage >= 20) {
      return "#FFF"
    } else {
      animateOpacity.start()
      return "#F22"
    }
  }
  property string iconPath: {
    if (Battery.percentage >= 95) {
      return "full"
    } else if (Battery.percentage >= 90) {
      return "6bar"
    } else if (Battery.percentage >= 75) {
      return "5bar"
    } else if (Battery.percentage >= 60) {
      return "4bar"
    } else if (Battery.percentage >= 45) {
      return "3bar"
    } else if (Battery.percentage >= 30) {
      return "2bar"
    } else if (Battery.percentage >= 20) {
      return "1bar"
    } else if (Battery.percentage < 20) {
      return "0bar"
    }
  }
  spacing: 2

  Image {
    id: icon

    source: `./assets/battery-${iconPath}.svg`
    visible: false
  }
  MultiEffect {
    id: iconEffect

    source: icon
    anchors.fill: icon
    colorization: 1
    colorizationColor: color // controls the color of the icon

    NumberAnimation {
      id: animateOpacity

      target: iconEffect
      properties: "opacity"
      from: 0.6
      to: 1.0
      loops: Animation.Infinite
      duration: 400
    }
  }
  Text {
    id: text

    text: `${Battery.percentage}%`
  }
}
