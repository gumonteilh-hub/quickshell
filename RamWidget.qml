import QtQuick
import Quickshell.Io
import "./components/"

MyButton {
    id: root
    label: "  " + root.ramUsage + "%"
    property string ramUsage: "0"

    onClicked: {
        if (!btopOpen.running)
            btopOpen.running = true;
    }

    Process {
        id: btopOpen
        command: ["footclient", "-e", "btop", "-p", "2"]
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: ramProcess.running = true
    }

    Process {
        id: ramProcess
        command: ["./stats.sh"]
        stdout: SplitParser {
            onRead: data => {
                try {
                    var stats = JSON.parse(data);
                    root.ramUsage = stats.ram;
                } catch (e) {
                    console.error("JSON parse error :" + e);
                }
            }
        }
    }
}
