import QtQuick

import Quickshell
import Quickshell.Io
import Quickshell.Wayland

import qs.services

PanelWindow {
  id: root

  readonly property string wallPath: `${Quickshell.env("HOME")}/.walls`
  property string currentWall
  property var files: []
  property real panelHeight: 100

  implicitHeight: panelHeight
  visible: AppState.wallPanelVisible

  onVisibleChanged: () => {
    if (visible) {
      lsProc.running = true
    }
  }

  focusable: true

  WlrLayershell.layer: WlrLayer.Top
  anchors {
    bottom: true
    left: true
    right: true
  }

  Process {
    id: lsProc
    command: ["bash", "-c", `ls ${wallPath}`]
    stdout: StdioCollector {
      onStreamFinished: {
        files = text.trim().split("\n")
      }
    }
  }

  Process {
    id: setProc
    command: ["bash", "-c", `${Quickshell.env("HOME")}/.config/hypr/scripts/set-wall.sh ${currentWall}`]
    running: false
  }

  function setWall(wall) {
    currentWall = `${wallPath}/${wall}`
    setProc.running = true
  }

  Item {
    focus: AppState.wallPanelVisible
    Keys.onPressed: (event) => {
      if (event.key == Qt.Key_Escape && AppState.wallPanelVisible) {
        event.accepted = true;
        AppState.wallPanelVisible = false;
      }
    }
  }

  Rectangle {
    anchors.fill: parent
    color: UI.clrBg

    Component {
      id: listDelegate
      Image {
        required property var modelData

        source: `file://${wallPath}/${modelData}`
        height: panelHeight
        fillMode: Image.PreserveAspectFit

        MouseArea {
          anchors.fill: parent
          onClicked: { 
            setWall(modelData)
          }
        }
      }
    }

    ListView {
      anchors.fill: parent
      orientation: Qt.Horizontal
      model: files
      delegate: listDelegate
    }
  }

  IpcHandler {
    target: "wallPanel"

    function toggle() {
      AppState.wallPanelVisible = !AppState.wallPanelVisible
    }
  }
}
