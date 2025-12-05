import QtQuick
import Quickshell.Io
import "./components/"

MyButton {
    id: root
    label: "  " + StatsProvider.cpuUsage + "%"

    onClicked: {
        if (!btopOpen.running)
            btopOpen.running = true;
    }

    Process {
        id: btopOpen
        command: ["footclient", "-e", "btop", "-p", "1"]
    }
}
