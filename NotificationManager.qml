import QtQuick
import Quickshell
import Quickshell.Services.Notifications

QtObject {
    id: root
    property var notifications: []

    function add(n) {
        n.tracked = true
        var list = notifications.slice()
        list.push(n)
        notifications = list
    }

    function remove(id) {
        var list = notifications.filter(n => n.id !== id)
        notifications = list
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
