pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Services.Notifications


Singleton {
  id: root

  property ListModel list: ListModel {
    id: list
  }

  property NotificationServer server: NotificationServer {
    id: server

    imageSupported: true
    actionsSupported: true

    onNotification: function(n) {
      if (!n) return;
      n.tracked = true;
      list.append({
        "n": n,
        "time": new Date(),
        "closed": false,
        "summary": n.summary,
        "body": n.body,
        "appIcon": n.appIcon,
        "image": n.image,
      });
    }
  }
}
