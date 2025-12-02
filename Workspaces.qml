import QtQuick
import Quickshell.Hyprland

Row {
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.margins: 6
    spacing: 5

    Repeater {
        model: Hyprland.workspaces

        delegate: Rectangle {
            id: workspace
            required property var modelData

            width: 24
            height: 24
            radius: 2
            color: modelData.id === Hyprland.focusedWorkspace.id || mouseArea.containsMouse ? "#cba6f7" : "#313244"

            Text {
                anchors.centerIn: parent
                text: workspace.modelData.id === Hyprland.focusedWorkspace.id ? "󱓻" : workspace.modelData.id
                color: workspace.modelData.id === Hyprland.focusedWorkspace.id ? "#11111b" : "#cdd6f4"
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    workspace.modelData.activate();
                }
            }
        }
    }
}
