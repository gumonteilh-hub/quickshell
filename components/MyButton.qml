import QtQuick
import "../style/"

Rectangle {
    id: button
    required property string label
    // property alias click: mouseArea.clicked

    width: textArea.implicitWidth + Theme.paddingLg
    height: parent.height

    radius: Theme.radiusSm

    color: mouseArea.containsMouse ? Theme.surfaceHigh : Theme.surfaceLow
    border.width: 1
    border.color: Theme.borderSubtle

    Text {
        id: textArea
        anchors.centerIn: parent
        text: parent.label
        color: Theme.textPrimary
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
    }
}
