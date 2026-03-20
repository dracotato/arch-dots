pragma Singleton

import QtQuick

import Quickshell

Singleton {
  id: root
  readonly property real hours: clock.hours
  readonly property real minutes: clock.minutes
  readonly property real seconds: clock.seconds
  readonly property string monthDaySuffix: {
    const day = format("dd")
    if (Number(day) > 3 && Number(day) < 20) {
      return "th"
    } else {
      switch (day[day.length-1]) {
        case "1":
          return "st"
          break;
        case "2":
          return "nd"
          break;
        case "3":
          return "rd";
          break;
        default:
        return "th"
      }
    }
  }

  function format(fmt) {
    return Qt.formatDateTime(clock.date, fmt)
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
