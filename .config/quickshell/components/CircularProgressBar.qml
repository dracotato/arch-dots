import Quickshell
import QtQuick
import QtQuick.Shapes

import qs.services

Item {
  property real progress: 0
  property real radius: 20
  property real strokeSize: 4
  property string trackClr: UI.clrBgLt
  property string strokeClr: UI.clrPrimary
  property string extraClr: UI.clrPrimaryLt

  implicitWidth: radius*2
  implicitHeight: radius*2

  Shape {
    preferredRendererType: Shape.CurveRenderer

    ShapePath {
      strokeWidth: strokeSize
      strokeColor: trackClr
      capStyle: ShapePath.RoundCap
      fillColor: "transparent"

      PathAngleArc {
        radiusX: radius; radiusY: radius
        centerX: radius; centerY: radius
        startAngle: -180
        sweepAngle: 360
      }
    }

    ShapePath {
      strokeWidth: strokeSize
      strokeColor: strokeClr
      capStyle: ShapePath.RoundCap
      fillColor: "transparent"

      PathAngleArc {
        radiusX: radius; radiusY: radius
        centerX: radius; centerY: radius
        startAngle: -180
        sweepAngle: progress*360
      }
    }

    ShapePath {
      strokeWidth: strokeSize
      strokeColor: progress > 1 ? extraClr : "transparent"
      capStyle: ShapePath.RoundCap
      fillColor: "transparent"

      PathAngleArc {
        radiusX: radius; radiusY: radius
        centerX: radius; centerY: radius
        startAngle: -180
        sweepAngle: (progress%1)*360
      }
    }
  }
}
