pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"
import "../singletons"

BarWidget {
  id: root

  name: 'clock'

  bar: Item {
    implicitHeight: Config.barHeight
    implicitWidth: text.implicitWidth + 16

    Text {
      id: text
      text: Time.time
      color: Catppuccin.text
      font.pixelSize: 14

      anchors.fill: parent
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
    }

    MouseArea {
      anchors.fill: parent
      acceptedButtons: Qt.LeftButton | Qt.RightButton
      cursorShape: Qt.PointingHandCursor
      onClicked: root.state = root.state === 'open' ? 'closed' : 'open'
    }
  }

  popup: ColumnLayout {
    spacing: 0
    
    RowLayout {
      ChevronButton {
        direction: 'left'
        Layout.leftMargin: 16
        onClicked: grid.changeMonth(-1)
      }
      
      Text {
        text: `${grid.locale.monthName(grid.month)} ${grid.year}`
        color: Catppuccin.text
        font.pixelSize: 16
        horizontalAlignment: Text.AlignHCenter
        
        Layout.fillWidth: true
        Layout.margins: 10
      }

      ChevronButton {
        direction: 'right'
        Layout.rightMargin: 16
        onClicked: grid.changeMonth(1)
      }
    }

    DayOfWeekRow {
      Layout.leftMargin: 10
      Layout.rightMargin: 10
      
      delegate: Text {
        required property string shortName

        width: 30

        text: shortName
        color: Catppuccin.text
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
      }
    }

    MonthGrid {
      id: grid

      Layout.fillWidth: true
      Layout.leftMargin: 10
      Layout.rightMargin: 10

      delegate: Rectangle {
        id: day
        required property var model
        
        implicitHeight: 30
        implicitWidth: 30

        color: model.today ? Catppuccin.withAlpha(Catppuccin.lavender, 0.2) : 'transparent'
        opacity: day.model.month === grid.month ? 1 : 0.5
        
        Text {
          text: grid.locale.toString(day.model.date, "d")
          color: Catppuccin.text
          anchors.fill: parent
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
        }
      }

      function changeMonth(by) {
        grid.year += Math.floor((grid.month + by) / 12)
        grid.month = (((grid.month + by) % 12) + 12) % 12
      }
    }
  }
}
