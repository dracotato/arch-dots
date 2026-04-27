pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property bool active: false

  Process {
    id: proc

    running: root.active
    command: [ "sh", "-c", "systemd-inhibit --what=idle:sleep --who=caffeine-mode --why='Too much coffee' sleep inf" ]
  }
}
