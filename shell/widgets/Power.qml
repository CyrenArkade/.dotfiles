pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.components
import qs.singletons

BarWidget {
  id: root
  name: 'power'

  bar: Item {
    implicitHeight: Config.barHeight
    implicitWidth: height

    Image {
      source: '../assets/power/power.svg'
      height: parent.height - 6
      width: height
      x: 3
      y: 3
      sourceSize.height: height
      sourceSize.width: width
    }

    MouseArea {
      anchors.fill: parent
      acceptedButtons: Qt.LeftButton | Qt.RightButton
      cursorShape: Qt.PointingHandCursor
      onClicked: root.state = root.state === 'open' ? 'closed' : 'open'
    }
  }

  popup: ColumnLayout {
    Repeater {
      model: [
        { icon: 'lock',    command: 'hyprlock' },
        { icon: 'suspend', command: 'systemctl suspend' },
        { icon: 'logout',  command: 'loginctl terminate-session $(cat /proc/self/sessionid)' },
        { icon: 'reboot',  command: 'systemctl reboot' },
        { icon: 'power',   command: 'systemctl poweroff' },
      ]

      Rectangle {
        id: item
        required property var modelData
        Layout.preferredHeight: Config.barHeight
        Layout.preferredWidth: height

        color: mouseArea.containsMouse ? Catppuccin.withAlpha(Catppuccin.lavender, 0.2) : 'transparent'

        Image {
          source: `../assets/power/${item.modelData.icon}.svg`
          height: parent.height - 6
          width: height
          x: 3
          y: 3
          sourceSize.height: height
          sourceSize.width: width
        }

        MouseArea {
          id: mouseArea
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          hoverEnabled: true
          onClicked: {
            root.state = 'closed'
            Quickshell.execDetached(['sh', '-c', item.modelData.command])
          }
        }
      }
    }

    Rectangle {
      implicitHeight: 10
    }
  }
}