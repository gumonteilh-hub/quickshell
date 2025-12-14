import QtQuick
import "../style/"

Rectangle {
  height: row.implicitHeight + 6
  width: row.implicitWidth + 7
  color: Theme.base
  radius: Theme.radiusMd

  Row {
    id: row
    height: 24
    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right
    anchors.rightMargin: 3
    spacing: 5

    LuminosityWidget {}
    AudioWidget {}
    InternetWidget {}
    BluetoothWidget {}
    RamWidget {}
    CpuWidget {}
    BatteryWidget {}
    PowerWidget {}
  }
}
