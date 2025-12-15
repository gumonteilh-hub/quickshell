import QtQuick
import Quickshell
import Quickshell.Hyprland
import "./bar/"

Scope {
  property var notificationManager

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
        active: modelData.name === Hyprland.focusedMonitor?.name
        sourceComponent: Component {
          NotificationPopup {
            parentWindow: barTopLevel
            anchorItem: widgets
            manager: notificationManager
          }
        }
      }
    }
  }
}
