pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Quickshell
import '../singletons'

Button {
  id: root
  required property QsMenuEntry entry

  signal hover(bool hasMouse)

  padding: 4

  onClicked: root.entry.triggered()

  contentItem: Loader {
    readonly property Component component: RowLayout {
      id: row

      spacing: 0
      opacity: root.entry.enabled ? 1 : 0.6

      Loader {
        active: root.entry.icon
        Layout.preferredHeight: 16
        Layout.preferredWidth: active ? height : 0
        Layout.leftMargin: active ? 2 : 0
        Layout.rightMargin: active ? 2 : 0
        sourceComponent: Image {
          source: root.entry.icon
          sourceSize.height: height
          sourceSize.width: width
        }
      }
      
      Loader {
        active: root.entry.buttonType
        Layout.fillHeight: true
        Layout.preferredWidth: active ? height : 0
        Layout.leftMargin: active ? 2 : 0
        Layout.rightMargin: active ? 2 : 0
        sourceComponent: Image {
          source: Config.asset(`${root.entry.buttonType === QsMenuButtonType.CheckBox ? 'checkbox' : 'radiobutton'}/${root.entry.checkState ? 'checked' : 'unchecked'}`)
          sourceSize.height: height
          sourceSize.width: width
        }
      }

      Text {
        text: root.entry.text
        color: Catppuccin.text
        verticalAlignment: Text.AlignVCenter
        Layout.fillWidth: true
        Layout.leftMargin: 2
        Layout.rightMargin: 2
      }
      
      Image {
        source: root.entry.hasChildren
          ? Config.asset('chevron/right.svg')
          : ''
        Layout.fillHeight: true
        Layout.preferredWidth: root.entry.hasChildren ? height : 0
        Layout.leftMargin: root.entry.hasChildren ? 2 : 0
        Layout.rightMargin: root.entry.hasChildren ? 2 : 0
        sourceSize.height: height
        sourceSize.width: width
      }
    }
    sourceComponent: root.entry ? component : undefined
  }

  background: Rectangle {
    color: root.entry?.enabled && mouseArea.containsMouse ? Catppuccin.withAlpha(Catppuccin.lavender, 0.2) : 'transparent'
    implicitHeight: 25

    MouseArea {
      id: mouseArea
      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true
      onHoveredChanged: root.hover(mouseArea.containsMouse)
      anchors.fill: parent
    }
  }
}