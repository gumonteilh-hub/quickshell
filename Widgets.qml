import QtQuick

Row {
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.margins: 6
    spacing: 5

    BluetoothWidget {}
    RamWidget {}
    CpuWidget {}

    PowerWidget {}
}
