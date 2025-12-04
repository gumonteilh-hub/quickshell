import QtQuick
import QtQuick.Controls
import Quickshell.Io
import Quickshell.Bluetooth
import "./components/"

Row {
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.margins: 6
    spacing: 5

    MyButton {
      label: "test"
    }

    BluetoothWidget {}
    
    Rectangle {
        width: ram.implicitWidth + 20
        height: 24
        radius: 2
        color: "#313244"

        Row {
            id: ram
            property string ramUsage: "0"
            anchors.centerIn: parent
            spacing: 8
            Timer {
                interval: 2000
                running: true
                repeat: true
                onTriggered: ramProcess.running = true
            }

            Process {
                id: ramProcess

                command: ["bash", "-c", "free | awk '/^Mem/ {printf(\"%.0f\", $3/$2 * 100)}'"]

                stdout: SplitParser {
                    onRead: data => {
                        ram.ramUsage = data;
                    }
                }
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: ""
                color: "white"
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: ram.ramUsage + "%"
                color: "white"
            }
        }
        Text {
            anchors.centerIn: parent
        }
    }

    Rectangle {
        width: cpu.implicitWidth + 20
        height: 24
        radius: 2
        color: "#313244"

        Row {
            id: cpu
            property string cpuUsage: "0"
            anchors.centerIn: parent
            spacing: 8
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
                            cpu.cpuUsage = stats.cpu;
                        } catch (e) {
                            console.error("JSON parse error :" + e);
                        }
                    }
                }
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: ""
                color: "white"
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: cpu.cpuUsage + "%"
                color: "white"
            }
        }
    }

    Rectangle {
        width: power.implicitWidth + 20
        height: 24
        radius: 2
        color: "red"
        HoverHandler {
            id: mouse
            cursorShape: Qt.PointingHandCursor
        }

        Row {
            id: power
            anchors.centerIn: parent
            spacing: 8
            Timer {
                interval: 2000
                running: true
                repeat: true
                onTriggered: cpuProcess.running = true
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "⏻"
                color: "black"
            }
        }

        Menu {
            id: powerPopup
            popupType: Popup.Window
            visible: mouse.hovered
            y: parent.y + parent.height + 5
            margins: 0
            width: 130
            height: powerPopupColumn.implicitHeight + 10
            modal: true
            focus: true
            closePolicy: Popup.CloseOnReleaseOutsideParent | Popup.CloseOnPressOutsideParent

            background: Rectangle {
                color: "#1e1e2e"
                border.color: "white"
                radius: 5
            }
            MenuItem {
                text: "Éteindre"
                icon.name: "system-shutdown-symbolic"
                icon.color: "red"
                Process {
                    id: shutdownProc
                    command: ["systemctl", "poweroff"]
                    running: false
                }
                onTriggered: {
                    shutdownProc.running = true;
                }
            }
            MenuItem {
                text: "Redémarrer"
                icon.name: "system-reboot-symbolic"
                icon.color: "green"
                Process {
                    id: rebootProc
                    command: ["systemctl", "reboot"]
                    running: false
                }
                onTriggered: {
                    rebootProc.running = true;
                }
            }

            //
            // contentItem: Column {
            //   id: powerPopupColumn
            //   width: parent.width
            //   Rectangle {
            //     color: mouseAreaPoweroff.containsMouse ? "grey" :"transparent"
            //     width: parent.width
            //     height: 40
            //     Row {
            //       anchors.verticalCenter: parent.verticalCenter
            //       spacing: 5
            //
            //       Text {
            //         width: 25
            //         text: ""; color: "white" }
            //         Text { text: "Power Off"; color: "white" }
            //       }
            //
            //       Process {
            //         id: shutdownProc
            //         command: ["systemctl", "poweroff"]
            //         running: false
            //       }
            //       MouseArea {
            //         id: mouseAreaPoweroff
            //
            //         anchors.fill: parent
            //         cursorShape: Qt.PointingHandCursor
            //         hoverEnabled: true
            //         onClicked: {
            //           shutdownProc.running = true
            //         }
            //       }
            //     }
            //
            //     Rectangle {
            //       color: rebootMouseArea.containsMouse ? "grey" :"transparent"
            //       width: parent.width
            //       height: 40
            //       Row {
            //         anchors.verticalCenter: parent.verticalCenter
            //         spacing: 5
            //
            //         Text {
            //           width: 25
            //           text: ""; color: "white" }
            //           Text { text: "Reboot"; color: "white" }
            //
            //         }
            //
            //         Process {
            //           id: rebootProc
            //           command: ["systemctl", "reboot"]
            //           running: false
            //         }
            //         MouseArea {
            //           id: rebootMouseArea
            //           anchors.fill: parent
            //           cursorShape: Qt.PointingHandCursor
            //           hoverEnabled: true
            //           onClicked: {
            //             rebootProc.running = true
            //           }
            //         }
            //       }
            //     }
        }
    }
}
