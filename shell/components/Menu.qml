pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import '../singletons'

ColumnLayout {
  id: root
  required property QsMenuHandle menu
  property real popupOpacity

  spacing: 0

  QsMenuOpener {
    id: opener
    menu: root.menu
  }
  
  Repeater {
    model: opener.children

    Loader {
      id: entry
      required property int index
      required property QsMenuEntry modelData
      property QsMenuEntry entry: modelData

      Layout.fillWidth: true

      property Component separator: Rectangle {
        implicitHeight: 1
        color: Catppuccin.surface1
        anchors {
          left: entry.left
          right: entry.right
          leftMargin: 10
          rightMargin: 10
        }
      }
      property Component button: MenuEntry {
        entry: entry.entry
        onHover: containsMouse => {
          if (containsMouse && popupLoader.entry != entry.entry)
            popupLoader.enabled = false
          if (containsMouse && entry.entry.hasChildren) {
            timer.restart()
            popupLoader.entry = entry.entry
            popupLoader.anchor = entry.item
          }
          else
            timer.stop()
        }
      }

      Timer {
        id: timer
        interval: 200
        onTriggered: popupLoader.enabled = true 
      }

      sourceComponent: entry.entry?.isSeparator ? separator : button
    }
  }

  Loader {
    id: popupLoader
    property bool enabled
    property QsMenuEntry entry
    property Item anchor

    active: popupLoader.enabled && entry
    sourceComponent: PopupWindow {

      implicitHeight: Math.max(1, popupMenu.implicitHeight)
      implicitWidth: Math.max(1, popupMenu.implicitWidth)

      anchor {
        item: popupLoader.anchor
        edges: Edges.Top | Edges.Right
      }

      visible: true

      color: 'transparent'
      
      Rectangle {
        width: parent.width
        height: parent.height
        
        color: Config.colors.barBg
        border {
          width: 1
          color: Config.colors.barBorder
        }

        opacity: root.popupOpacity
        
        BoundComponent {
          id: popupMenu
          source: 'Menu.qml'
          property var menu: popupLoader.entry
        }
      }
    }
  }
}