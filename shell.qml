import QtQuick
import Quickshell

ShellRoot {
  NotificationManager {
    id: notificationManager
  }

  Bar {
    notificationManager: notificationManager
  }
}