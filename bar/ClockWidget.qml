import QtQuick
import "../style/"

Row {
  anchors.horizontalCenter: parent.horizontalCenter

  Rectangle {
    height: 24
    width: contentRow.implicitWidth + 20
    radius: Theme.radiusLg
    color: Theme.mauve

    Row {
      id: contentRow
      anchors.centerIn: parent
      spacing: 4
      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: ""
        color: Theme.crust
      }
      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: Time.time
        color: Theme.crust
      }
    }
  }
}
