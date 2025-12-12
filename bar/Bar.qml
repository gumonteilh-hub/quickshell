import QtQuick
import Quickshell

Scope {
  Variants {
    model: Quickshell.screens
    PanelWindow {
      id: barTopLevel
      required property var modelData

      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }
      margins {
        right: 5
        left: 5
        top: 5
      }
      color: "transparent"
      implicitHeight: 30

      Workspaces {}

      ClockWidget {
        anchors.centerIn: parent
      }

      Widgets {}
    }
  }
}
