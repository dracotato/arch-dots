pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Services.Notifications


Singleton {
  id: root

  property NotificationServer server: NotificationServer {
    id: notifServer

    imageSupported: true
    actionsSupported: true
    onNotification: function(notif) {
      notif.tracked = true;
    }
  }
}
