import QtQuick
import "../style/"

Rectangle {
    id: root
    required property string label
    property color labelColor: Theme.textPrimary
    property string tooltip
    signal clicked
    readonly property alias hovered: mouseArea.containsMouse

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
        color: root.labelColor
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
