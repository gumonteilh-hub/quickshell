import QtQuick
import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Widgets
import "./style/"

PopupWindow {
  id: root
  property list<Notification> notifications: []
  required property var parentWindow
  required property var anchorItem
  anchor {
    window: parentWindow
    item: anchorItem
    edges: Edges.Bottom | Edges.Right
    gravity: Edges.Bottom
  }
  visible: notifications.length > 0
  implicitWidth: content.width
  implicitHeight: content.height

  NotificationServer {
    onNotification: notification => {
      notification.tracked = true;
      root.notifications.push(notification);
    }
  }
  color: "transparent"

  Column {
    id: content
    width: 400
    spacing: 15
    topPadding: 5

    Repeater {
      model: root.notifications

      delegate: Row {
        id: row
        required property var modelData

        Timer {
          id: expireTimer
          interval: row.modelData.expireTimeout > 0 ? row.modelData.expireTimeout : 10000
          running: true
          repeat: false
          onTriggered: {
            root.notifications = root.notifications.filter(n => n.id != row.modelData.id);
          }
        }

        anchors.horizontalCenter: content.horizontalCenter
        Rectangle {
          color: {
            switch (modelData.urgency) {
            case 2:
              return Theme.red;
            case 0:
              return Theme.surfaceLow;
            case 1:
              return Theme.surfaceLow;
            }
          }
          border.color: Theme.borderStrong
          border.width: 5
          radius: Theme.radiusSm
          width: 350
          height: 100

          Column {
            anchors.fill: parent
            anchors.margins: 10

            Item {
              width: parent.width
              height: 26

              Text {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 14
                text: modelData.summary
              }

              IconImage {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                source: Quickshell.iconPath(modelData.appIcon, "application-x-executable")
                implicitSize: 26
              }
            }

            Text {
              topPadding: 10
              text: modelData.body
            }
          }

          MouseArea {
            hoverEnabled: true
            anchors.fill: parent
            onClicked: {
              root.notifications = root.notifications.filter(n => n.id != row.modelData.id);
            }
          }
        }
      }
    }
  }
}
