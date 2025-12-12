import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import "../components/"
import "../style/"

MyButton {
  id: root
  height: 24
  label: ""

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
    onVisibleChanged: {
      gammaProc.running = true;
      temperatureProc.running = true;
    }

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

        Column {
          id: column
          anchors.centerIn: parent
          spacing: 5
          Text {
            text: "Luminosité"
          }
          Row {
            spacing: 5
            Text {
              text: ""
              color: Theme.mauve
            }

            Process {
              id: gammaProc
              command: ["hyprctl", "hyprsunset", "gamma"]

              stdout: StdioCollector {
                onStreamFinished: {
                  gammaSlider.value = data;
                  gammaSlider.initialized = true;
                }
              }
            }

            Process {
              id: writeGammaProc
            }

            Slider {
              id: gammaSlider
              property bool initialized: false
              from: 10
              to: 100
              stepSize: 5
              width: 150
              anchors.verticalCenter: parent.verticalCenter

              onValueChanged: {
                if (initialized) {
                  writeGammaProc.command = ["hyprctl", "hyprsunset", "gamma", value.toString()];
                  writeGammaProc.running = true;
                }
              }
            }

            Text {
              text: ""
              color: Theme.yellow
            }
          }

          Text {
            text: "température"
          }
          Row {
            spacing: 5
            Text {
              text: ""
              color: Theme.red
            }

            Process {
              id: temperatureProc
              command: ["hyprctl", "hyprsunset", "temperature"]

              stdout: StdioCollector {
                onStreamFinished: {
                  temperatureSlider.value = data;
                  temperatureSlider.initialized = true;
                }
              }
            }

            Process {
              id: writeTemperatureProc
            }

            Slider {
              id: temperatureSlider
              property bool initialized: false
              from: 0
              to: 6000
              stepSize: 100
              width: 150
              anchors.verticalCenter: parent.verticalCenter

              Component.onCompleted: {
                temperatureProc.running = true;
              }

              onValueChanged: {
                if (initialized) {
                  writeTemperatureProc.command = ["hyprctl", "hyprsunset", "temperature", value.toString()];
                  writeTemperatureProc.running = true;
                }
              }
            }

            Text {
              text: ""
              color: Theme.blue
            }
          }
        }
      }
    }
  }
}
