pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root
  readonly property real hours: clock.hours
  readonly property real minutes: clock.minutes
  readonly property real seconds: clock.seconds

  readonly property string time: {
    Qt.formatDateTime(clock.date, "h:mm:ss AP")
  }
  readonly property string date: {
    Qt.formatDateTime(clock.date, "dddd M/d")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
