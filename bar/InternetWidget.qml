import QtQuick
import Quickshell.Io
import "../components/"
import "../style/"

MyButton {
  id: root
  height: 24
  property bool connected: false
  property string type: "none"
  label: {
    if (!root.connected) {
      return "󰖪";
    }
    if (type === "wifi") {
      return "";
    } else {
      return "󰀂";
    }
  }
  labelColor: {
    if (!root.connected) {
      Theme.red;
    } else {
      Theme.textPrimary;
    }
  }
  onClicked: {
    if (!nmtuiOpen.running)
      nmtuiOpen.running = true;
  }

  Process {
    id: nmtuiOpen
    command: ["footclient", "-e", "nmtui"]
  }

  Process {
    id: nmProc
    command: ["bash", "-c", "echo \"$(nmcli -t -f CONNECTIVITY general):$(nmcli -t -f TYPE,STATE connection | grep activated | head -1 | cut -d: -f1)\""]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        // Output format: "full:802-3-ethernet" ou "none:"
        const line = this.text.trim();
        const parts = line.split(":");

        root.connected = parts[0] === "full";

        const rawType = parts[1] || "";
        if (rawType.includes("ethernet")) {
          root.type = "ethernet";
        } else if (rawType.includes("wireless")) {
          root.type = "wifi";
        } else {
          root.type = "none";
        }
      }
    }
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: nmProc.running = true
  }
}
