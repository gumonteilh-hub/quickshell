import QtQuick
import Quickshell.Services.Mpris
import "../components/"
import "../style/"

Rectangle {
  id: mediaWidget
  height: 30
  width: row.implicitWidth + 10
  radius: Theme.radiusLg
  color: Theme.crust
  visible: Mpris.players.values.filter(p => p.canPlay).length > 0

  property var player: Mpris.players.values.filter(p => p.canPlay).length > 0 ? Mpris.players.values.filter(p => p.canPlay)[0] : null

  Row {
    id: row
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    height: 30
    spacing: 8
    Component.onCompleted: console.log(JSON.stringify(mediaWidget.player))
    Text {
      anchors.verticalCenter: parent.verticalCenter
      color: Theme.subtext1
      width: Math.min(implicitWidth, 300)
      elide: Text.ElideRight
      text: mediaWidget.player ? ("🎵 " + mediaWidget.player.trackTitle) : ""
    }

    Text {
      anchors.verticalCenter: parent.verticalCenter
      color: Theme.subtext1
      width: Math.min(implicitWidth, 150)
      elide: Text.ElideRight
      text: mediaWidget.player ? (" - " + mediaWidget.player.trackArtist) : ""
    }
    MyButton {
      label: "󰒮"
      height: 24
      anchors.verticalCenter: parent.verticalCenter
      onClicked: () => mediaWidget.player.previous()

      radius: 100
    }

    MyButton {
      visible: !mediaWidget.player.isPlaying
      label: "󰐊"
      height: 24
      anchors.verticalCenter: parent.verticalCenter
      onClicked: () => mediaWidget.player.play()
      radius: 100
    }
    MyButton {
      visible: mediaWidget.player.isPlaying
      label: "󰏤"
      height: 24
      anchors.verticalCenter: parent.verticalCenter
      onClicked: () => mediaWidget.player.pause()
      radius: 100
    }

    MyButton {
      label: "󰒭"
      height: 24
      anchors.verticalCenter: parent.verticalCenter
      onClicked: () => mediaWidget.player.next()
      radius: 100
    }
  }
}
