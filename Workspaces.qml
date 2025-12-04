import QtQuick
import Quickshell.Hyprland
import Quickshell.Io
import "./components/"
import "./style/"

Row {
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.margins: 6
    spacing: 5

    Rectangle {
        width: 24
        height: 24
        color: "transparent"

        Text {
            text: "󱄅"
            color: Theme.sky
            anchors.centerIn: parent
        }
        Process {
            id: fastfetch
            command: ["footclient", "-H", "-e", "fastfetch"]
        }

        MouseArea {
            cursorShape: Qt.PointingHandCursor
            anchors.fill: parent
            onClicked: {
                if (!fastfetch.running)
                    fastfetch.running = true;
            }
        }
    }
    Repeater {
        model: Hyprland.workspaces

        delegate: MyButton {
            id: workspace
            required property var modelData
            label: workspace.modelData.id === Hyprland.focusedWorkspace.id ? "󱓻" : workspace.modelData.id === -98 ? "" : workspace.modelData.id
            labelColor: workspace.modelData.id === Hyprland.focusedWorkspace.id ? Theme.crust : Theme.text

            width: 24
            height: 24
            color: modelData.id === Hyprland.focusedWorkspace.id || mouseArea.containsMouse ? Theme.mauve : Theme.surfaceLow

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
