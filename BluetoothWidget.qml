import QtQuick
import Quickshell
import Quickshell.Bluetooth
import Quickshell.Io
import "./components/"
import "./style/"

MyButton {
    id: bluetoothButton
    height: 24
    label: "󰂯 " + Bluetooth.devices.values.length

    Process {
        id: nmtuiOpen
        command: ["footclient", "-e", "bluetui"]
    }

    onClicked: {
        if (!nmtuiOpen.running)
            nmtuiOpen.running = true;
    }

    PopupWindow {
        anchor {
            window: barTopLevel
            item: bluetoothButton
            edges: Edges.Bottom
            gravity: Edges.Bottom
        }
        visible: bluetoothButton.hovered
        color: "transparent"
        implicitWidth: content.width
        implicitHeight: content.height

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
                Repeater {
                    model: Bluetooth.devices.values

                    delegate: Row {
                        required property var modelData
                        spacing: 8

                        Text {
                            width: 14

                            horizontalAlignment: Text.AlignHCenter
                            text: {
                                if (modelData.icon.includes("keyboard")) {
                                    return "";
                                } else if (modelData.icon.includes("mouse")) {
                                    return "󰍽";
                                }
                                return "";
                            }
                            font.pixelSize: 11
                            color: "white"
                        }
                        Text {
                            width: 80
                            elide: Text.ElideRight
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 11
                            text: modelData.deviceName
                            color: "white"
                        }
                        Text {
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 11
                            text: {
                                let batteryIcon = "";
                                const battery = Math.trunc(modelData.battery * 100);
                                if (battery < 10) {
                                    batteryIcon = "󰤾 ";
                                } else if (battery < 20) {
                                    batteryIcon = "󰤿 ";
                                } else if (battery < 30) {
                                    batteryIcon = "󰥀 ";
                                } else if (battery < 40) {
                                    batteryIcon = "󰥁 ";
                                } else if (battery < 50) {
                                    batteryIcon = "󰥂 ";
                                } else if (battery < 60) {
                                    batteryIcon = "󰥃 ";
                                } else if (battery < 70) {
                                    batteryIcon = "󰥄 ";
                                } else if (battery < 80) {
                                    batteryIcon = "󰥅 ";
                                } else if (battery < 90) {
                                    batteryIcon = "󰥆 ";
                                } else if (battery < 100) {
                                    batteryIcon = "󰥈 ";
                                }

                                return batteryIcon + battery + "%";
                            }
                            color: "white"
                        }
                    }
                }
            }
        }
    }
}
