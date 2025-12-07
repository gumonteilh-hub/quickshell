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
      color: "#1e1e2e"
      implicitHeight: 30

      Workspaces {}

      ClockWidget {
        anchors.centerIn: parent
      }

      Widgets {}
    }
  }
}
