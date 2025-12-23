import QtQuick
import Quickshell.Io
import "../components/"
import "../style/"

MyButton {
  id: root
  height: 24
  width: 60
  labelColor: {
    const cpuUsage = StatsProvider.cpuUsage;
    if (cpuUsage > 95) {
      return Theme.red;
    }
    if (cpuUsage > 80) {
      return Theme.peach;
    }
    return Theme.textPrimary;
  }
  label: "   " + StatsProvider.cpuUsage + "%"

  onClicked: {
    if (!btopOpen.running)
      btopOpen.running = true;
  }

  Process {
    id: btopOpen
    command: ["footclient", "-e", "btop", "-p", "1"]
  }
}
