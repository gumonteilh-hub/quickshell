pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property int cpuUsage: 0
  property int ramUsage: 0

  property var _process: Process {
    running: true
    command: ["/home/gmonteilhet/.config/quickshell/stats.sh"]
    stdout: SplitParser {
      onRead: data => {
        try {
          var stats = JSON.parse(data);
          root.cpuUsage = stats.cpu;
          root.ramUsage = stats.ram;
        } catch (e) {
          console.error("Stats parse error:", e);
        }
      }
    }
  }
}
