import QtQuick
import Quickshell
import Quickshell.Widgets
import "./style/"

PopupWindow {
  id: root

  required property var manager
  required property var parentWindow
  required property var anchorItem

  anchor {
    window: parentWindow
    item: anchorItem
    edges: Edges.Bottom | Edges.Right
    gravity: Edges.Bottom
  }

  visible: manager.notifications.count > 0
  implicitWidth: content.width
  implicitHeight: content.height
  color: "transparent"

  Column {
    id: content
    width: 400
    spacing: 15
    topPadding: 5

    Repeater {
      model: root.manager.notifications

      delegate: Row {
        id: row
        required property var model

        property var notif: model.notification

        Timer {
          id: expireTimer
          interval: row.notif && row.notif.expireTimeout > 0 ? row.notif.expireTimeout : 10000
          running: row.notif !== null
          repeat: false
          onTriggered: {
            if (row.notif) root.manager.remove(row.notif.id);
          }
        }

        anchors.horizontalCenter: content.horizontalCenter
        Rectangle {
          visible: row.notif !== null
          color: {
            if (!row.notif) return Theme.surfaceLow;
            switch (row.notif.urgency) {
            case 2:
              return Theme.red;
            case 0:
              return Theme.surfaceLow;
            case 1:
              return Theme.surfaceLow;
            default:
              return Theme.surfaceLow;
            }
          }
          border.color: Theme.borderStrong
          border.width: 5
          radius: Theme.radiusSm
          width: 350
          height: column.implicitHeight + 20

          Column {
            id: column
            anchors.fill: parent
            anchors.margins: 10

            Item {
              width: parent.width
              height: title.implicitHeight

              Text {
                id: title
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                maximumLineCount: 2
                wrapMode: Text.Wrap
                width: 300
                elide: Text.ElideRight
                font.pointSize: 14
                text: row.notif ? row.notif.summary : ""
              }

              IconImage {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                source: row.notif ? Quickshell.iconPath(row.notif.appIcon, "application-x-executable") : ""
                implicitSize: 26
              }
            }

            Text {
              topPadding: 11
              width: 300
              maximumLineCount: 5
              wrapMode: Text.Wrap
              elide: Text.ElideRight
              text: row.notif ? row.notif.body : ""
            }
          }

          MouseArea {
            hoverEnabled: true
            anchors.fill: parent
            onClicked: {
              if (row.notif) root.manager.remove(row.notif.id);
            }
          }
        }
      }
    }
  }
}
