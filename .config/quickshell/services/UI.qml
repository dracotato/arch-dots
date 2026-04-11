pragma Singleton

import QtQuick

import Quickshell

Singleton {
  id: root


  readonly property real barHeight: 48

  readonly property real barPadding: 8
  readonly property real barComponentGap: 12
  readonly property real barSectionGap: 48

  readonly property real osdScreenPad: 48

  readonly property real notifWidth: 400

  readonly property string clrBg: "#13181e"
  readonly property string clrBgLt: "#445"
  readonly property string clrBgLtr: "#2d2d38"
  readonly property string clrFg: "#eef"
  readonly property string clrFgLt: "#bbc"
  readonly property string clrDanger: "#f22"
  readonly property string clrPrimary: "#66e"
  readonly property string clrPrimaryLt: "#aaf"

  readonly property real txtSize: 16
  readonly property real txtSizeSmall: 12

  readonly property real iconSizeBig: 24
  readonly property real iconSize: 18

  readonly property real txtWeight: 500
  readonly property real txtWeightBold: 700
}
