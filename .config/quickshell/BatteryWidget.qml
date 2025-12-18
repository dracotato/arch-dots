import QtQuick

import qs.services


Row {
  readonly property string assetsPath: "assets"
  readonly property Text text: text
  property string color: {
    if (Battery.percentage >= 20) {
      return "#FFF"
    } else {
      return "#F22"
    }
  }
  spacing: 2

  function updateIcon() {
    let size = 20;
    let properties = {"height": size, "width": size, "color": color};

    if (Battery.percentage >= 95) {
      iconLoader.setSource(`${assetsPath}/BatteryFull.qml`, properties)
    } else if (Battery.percentage >= 90) {
      iconLoader.setSource(`${assetsPath}/Battery6bar.qml`, properties)
    } else if (Battery.percentage >= 75) {
      iconLoader.setSource(`${assetsPath}/Battery5bar.qml`, properties)
    } else if (Battery.percentage >= 60) {
      iconLoader.setSource(`${assetsPath}/Battery4bar.qml`, properties)
    } else if (Battery.percentage >= 45) {
      iconLoader.setSource(`${assetsPath}/Battery3bar.qml`, properties)
    } else if (Battery.percentage >= 30) {
      iconLoader.setSource(`${assetsPath}/Battery2bar.qml`, properties)
    } else if (Battery.percentage >= 20) {
      iconLoader.setSource(`${assetsPath}/Battery1bar.qml`, properties)
    } else if (Battery.percentage < 20) {
      iconLoader.setSource(`${assetsPath}/Battery0bar.qml`, properties)
    }
  }

  Loader {
    id: iconLoader
    sourceComponent: updateIcon() // initial icon setup

    anchors.verticalCenter: parent.verticalCenter

    Connections {
      target: Battery
      onPercentageChanged: updateIcon()
    }
  }
  Text {
    id: text

    anchors.verticalCenter: parent.verticalCenter

    text: `${Battery.percentage}%`
  }
}
