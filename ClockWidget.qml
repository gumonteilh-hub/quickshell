import QtQuick

Row {
  anchors.horizontalCenter: parent.horizontalCenter

  Rectangle {
    height: 24
    width: contentRow.implicitWidth + 20
    radius: 2
    color:  "#cba6f7"

    Row {
      id: contentRow
      anchors.centerIn: parent
      spacing: 8 

      Text {
        anchors.verticalCenter : parent.verticalCenter
        text: "" 
        color: "#11111b"
      }

      Text {
        anchors.verticalCenter : parent.verticalCenter
        text: Time.time
        color: "#11111b"
      }
    }
  }
}
