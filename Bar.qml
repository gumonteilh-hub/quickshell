import Quickshell
import QtQuick.Controls
import QtQuick
import "./components/"

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

            height: 30

            Workspaces {}

            ClockWidget {
                anchors.centerIn: parent
            }

            Widgets {}
        }
    }
}
