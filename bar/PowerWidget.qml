import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import "../components/"
import "../style/"

MyButton {
  id: root
  width: 24
  height: 24
  label: "⏻"
  radius: Theme.radiusMd
  color: Theme.red
  labelColor: Theme.crust

  PopupWindow {
    id: popup
    anchor {
      window: barTopLevel
      item: root
      edges: Edges.Bottom
      gravity: Edges.Bottom
    }
    visible: root.hovered || mouseArea.containsMouse
    color: "transparent"
    implicitWidth: content.width
    implicitHeight: content.height

    MouseArea {
      id: mouseArea
      hoverEnabled: true
      anchors.fill: parent
      Rectangle {
        id: content
        color: Theme.overlayLow
        border.color: Theme.borderStrong
        border.width: 3
        radius: Theme.radiusSm
        width: column.width + Theme.paddingLg
        height: column.height + Theme.paddingLg

        ColumnLayout {
          id: column
          anchors.centerIn: parent
          spacing: 5
          MyButton {
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            color: Theme.red
            labelColor: Theme.crust
            label: "Eteindre"
            onClicked: shutdownProcess.running = true

            Process {
              id: shutdownProcess
              command: ["systemctl", "poweroff"]
            }
          }
          MyButton {
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            color: Theme.green
            labelColor: Theme.crust
            label: "Redémarrer"
            onClicked: rebootProcess.running = true

            Process {
              id: rebootProcess
              command: ["systemctl", "reboot"]
            }
          }
          MyButton {
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            color: Theme.yellow
            labelColor: Theme.crust
            label: "Verrouiller"
            onClicked: lockProcess.running = true

            Process {
              id: lockProcess
              command: ["hyprlock"]
            }
          }
        }
      }
    }
  }
}
