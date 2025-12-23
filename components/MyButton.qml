import QtQuick
import "../style/"

Rectangle {
  id: root
  required property string label
  property color labelColor: Theme.textPrimary
  property bool withDialogOnHover: false
  property color background
  signal clicked
  readonly property alias hovered: mouseArea.containsMouse

  width: textArea.implicitWidth + Theme.paddingLg
  height: parent.height
  bottomRightRadius: {
    if (withDialogOnHover && hovered) {
      return 0;
    }
  }
  bottomLeftRadius: {
    if (withDialogOnHover && hovered) {
      return 0;
    }
  }
  radius: Theme.radiusSm
  color: {
    if (background != "#000000")
      return background;

    return mouseArea.containsMouse ? Theme.surfaceHigh : Theme.surfaceLow;
  }
  border.width: 1
  border.color: {
    if (withDialogOnHover && hovered) {
      return Theme.surfaceHigh;
    }

    return Theme.borderSubtle;
  }

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
