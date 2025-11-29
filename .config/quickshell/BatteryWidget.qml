import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

RowLayout {
  readonly property Text text: text
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

  Image {
    id: icon
    source: `./assets/battery-${iconPath}.svg`
    visible: false
  }
  MultiEffect {
    source: icon
    anchors.fill: icon
    colorization: 1
    colorizationColor: "#FFF" // controls the color of the icon
  }
  Text {
    id: text
    text: `${Battery.percentage}%`
  }
}
