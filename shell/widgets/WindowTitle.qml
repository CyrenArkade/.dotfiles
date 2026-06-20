import QtQuick
import Quickshell.Hyprland
import "../singletons"


Text {
  id: text
  color: Catppuccin.text
  font.pixelSize: 14

  Connections {
    target: Hyprland

    function onRawEvent(event) {
      if (event.name == 'activewindow')
        text.text = event.data.slice(event.data.indexOf(',') + 1)
    }
  }
}