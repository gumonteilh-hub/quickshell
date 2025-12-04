import QtQuick
import Quickshell.Io
import "./components/"

MyButton {
    id: root
    property string cpuUsage: "0"
    label: "  " + root.cpuUsage + "%"

    onClicked: {
        if (!btopOpen.running)
            btopOpen.running = true;
    }

    Process {
        id: btopOpen
        command: ["footclient", "-e", "btop", "-p", "1"]
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: cpuProcess.running = true
    }

    Process {
        id: cpuProcess
        command: ["./stats.sh"]
        stdout: SplitParser {
            onRead: data => {
                try {
                    var stats = JSON.parse(data);
                    root.cpuUsage = stats.cpu;
                } catch (e) {
                    console.error("JSON parse error :" + e);
                }
            }
        }
    }
}
