import QtQuick
import Quickshell
import Quickshell.Services.Notifications

QtObject {
    id: root
    property alias notifications: notificationModel

    property ListModel notificationModel: ListModel {
        id: notificationModel
    }

    function add(n) {
        n.tracked = true
        notificationModel.append({"notification": n})
    }

    function remove(id) {
        for (var i = 0; i < notificationModel.count; i++) {
            if (notificationModel.get(i).notification.id === id) {
                notificationModel.remove(i)
                break
            }
        }
    }

    property var server: NotificationServer {
        bodySupported: true
        bodyMarkupSupported: true
        bodyImagesSupported: true
        keepOnReload: false
        actionsSupported: true
        persistenceSupported: true
        actionIconsSupported: true

        onNotification: notification => root.add(notification)
    }
}
