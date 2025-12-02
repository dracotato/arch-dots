import QtQuick
import QtQuick.Layouts
import QtQuick.Effects


RowLayout {
  readonly property string assetsPath: "assets"
  readonly property Text text: text
  property string color: {
    if (Battery.percentage >= 20) {
      return "#FFF"
    } else {
      animateOpacity.start()
      return "#F22"
    }
  }
  spacing: 2

  function updateIcon() {
    let size = 22;
    let properties = {"implicitHeight": size, "implicitWidth": size};

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

    Connections {
      target: Battery
      onPercentageChanged: updateIcon()
    }
  }
  Text {
    id: text

    text: `${Battery.percentage}%`
  }
}
