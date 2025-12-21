pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root
  readonly property string time: {
    Qt.formatDateTime(clock.date, "h:mm:ss AP • ddd d'th' MMM")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
