pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
  id: root
  readonly property real rawPercentage: UPower.displayDevice.percentage ?? 1
  readonly property int percentage: Math.trunc(rawPercentage*100)
  readonly property bool isCharging: UPower.displayDevice.state == UPowerDeviceState.Charging
}
