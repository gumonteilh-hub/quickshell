import QtQuick
import Quickshell.Io
import "../components/"
import "../style/"

MyButton {
  id: root
  height: 24
  width: 60
  labelColor: {
    const ramUsage = StatsProvider.ramUsage;
    if (ramUsage > 80) {
      return Theme.red;
    }
    if (ramUsage > 60) {
      return Theme.peach;
    }
    return Theme.textPrimary;
  }
  label: "   " + StatsProvider.ramUsage + "%"

  onClicked: {
    if (!btopOpen.running)
      btopOpen.running = true;
  }

  Process {
    id: btopOpen
    command: ["footclient", "-e", "btop", "-p", "2"]
  }
}
