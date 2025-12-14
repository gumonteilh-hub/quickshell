import QtQuick
import Quickshell
import "./bar/"

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

      Row {
        spacing: 25
        anchors.right: parent.right
        MediaPlayerWidget {}
        Widgets {
          id: widgets
        }
      }

      Loader {
        active: modelData === Quickshell.screens[0]
        sourceComponent: NotificationServer {
          parentWindow: barTopLevel
          anchorItem: widgets
        }
      }
    }
  }
}
