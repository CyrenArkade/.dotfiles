pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import qs.components
import qs.singletons

BarWidget {
  id: root

  property QsMenuHandle menu

  name: 'tray'
  
  bar: Item {
    implicitHeight: row.implicitHeight
    implicitWidth: row.implicitWidth

    MouseArea {
      anchors.fill: parent
      onClicked: root.state = 'closed'
    }
    
    RowLayout {
      id: row

      spacing: 0
      anchors.centerIn: parent

      Repeater {
        id: repeater
        model: SystemTray.items

        Item {
          id: item
          required property int index
          required property SystemTrayItem modelData
          readonly property SystemTrayItem trayItem: modelData
    
          Layout.preferredHeight: Config.barHeight

          readonly property int margin: 4
          readonly property int leftMargin: margin / (index == 0 ? 1 : 2)
          readonly property int rightMargin: margin / (index == repeater.count-1 ? 1 : 2)
          
          implicitWidth: child.width + leftMargin + rightMargin

          Image {
            id: child
            x: parent.leftMargin
            y: parent.margin
            height: parent.height - 2 * parent.margin
            width: height
            sourceSize.width: width
            sourceSize.height: height
            source: item.trayItem.icon
          }

          MouseArea {
            anchors.fill: parent
            cursorShape: item.trayItem.onlyMenu ? undefined : Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
            onClicked: event => {
              if (event.button == Qt.RightButton || item.trayItem.onlyMenu) {
                root.state = root.state === 'open' && root.menu == item.trayItem.menu
                  ? 'closed'
                  : 'open'
                root.menu = item.trayItem.menu
              }
              if (event.button == Qt.LeftButton)
                item.trayItem.activate()
              else if (event.button == Qt.MiddleButton)
                item.trayItem.secondaryActivate()
            }
          }
        }
      }
    }
  }

  popup: Menu {
    menu: root.menu
    popupOpacity: root.popupOpacity
  }
}