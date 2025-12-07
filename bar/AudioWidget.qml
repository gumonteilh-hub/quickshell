import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import "../components/"
import "../style/"

MyButton {
  id: root
  label: {
    let audio = Pipewire.defaultAudioSink.audio;
    if (audio.muted) {
      return "󰝟";
    }
    if (audio.volume > 0.7) {
      return "󰕾";
    }
    if (audio.volume > 0.3) {
      return "󰖀";
    }
    return "󰕿";
  }

  onClicked: {
    if (!pavucontrolGui.running)
      pavucontrolGui.running = true;
  }

  Process {
    id: pavucontrolGui
    command: ["pavucontrol"]
  }

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

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

        Column {
          id: column
          anchors.centerIn: parent
          spacing: 5

          Row {
            Repeater {
              model: Pipewire.nodes.values.filter(n => n.isSink && n.audio && !n.isStream)

              delegate: MyButton {
                required property var modelData
                label: modelData.nickname === "" ? modelData.description : modelData.nickname
                color: modelData.id === Pipewire.defaultAudioSink.id ? Theme.surfaceLowest : Theme.surfaceHigh

                onClicked: Pipewire.preferredDefaultAudioSink = modelData

                height: 30
              }
            }
          }

          Row {
            Text {
              text: "master volume"
            }
          }
          Row {
            spacing: 5
            Text {
              text: ""
            }

            Slider {
              id: masterVolumeSlider
              from: 0
              to: 100
              value: Pipewire.defaultAudioSink.audio.volume * 100 || 0
              stepSize: 1
              width: 150
              anchors.verticalCenter: parent.verticalCenter

              Component.onCompleted: {
                console.log("ici");
                masterVolumeSlider.value = Pipewire.defaultAudioSink.audio.volume * 100;
              }

              onMoved: {
                Pipewire.defaultAudioSink.audio.volume = value / 100;
              }
            }

            Text {
              text: ""
            }
          }
        }
      }
    }
  }
}
