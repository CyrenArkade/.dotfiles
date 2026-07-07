import QtQuick
import QtQuick.Controls.Basic
import '../singletons'

Slider {
  id: control

  property bool dead: false

  padding: 0

  background: Rectangle {
    x: control.leftPadding
    y: control.topPadding + control.availableHeight / 2 - height / 2
    implicitWidth: 200
    implicitHeight: 4
    width: control.availableWidth
    height: implicitHeight
    color: Catppuccin.surface0

    Rectangle {
      width: control.visualPosition * parent.width
      height: parent.height
      color: control.dead ? Catppuccin.overlay1 : Catppuccin.lavender
      radius: 2
    }
  }

  handle: Rectangle {
    x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
    y: control.topPadding + control.availableHeight / 2 - height / 2
    implicitWidth: 14
    implicitHeight: 14
    color: control.dead ? Catppuccin.overlay2
      : control.pressed ? Catppuccin.lavender
      : Catppuccin.text
  }
}