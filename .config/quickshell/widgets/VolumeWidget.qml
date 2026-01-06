import QtQuick

import qs.components
import qs.services

CircularIndicator {
  progress: Volume.muted ? 0 : Volume.rawPercentage
  textContent: {
    if (Volume.percentage <= 0 || Volume.muted) {
      return "󰝟";
    } else if (Volume.percentage > 100) {
      return "󱄡";
    } else if (Volume.percentage > 60) {
      return "󰕾";
    } else if (Volume.percentage > 10) {
      return "󰖀";
    } else {
      return "󰕿";
    }
  }
}
