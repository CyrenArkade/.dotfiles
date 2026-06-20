pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
import qs.components
import qs.singletons

BarWidget {
  id: root
  name: 'battery'

  bar: Item {
    implicitHeight: parent.height
    implicitWidth: implicitHeight

    Image {
      id: img
      source: `../assets/battery/${UPower.onBattery ? 'normal' : 'charging'}/${Math.min(Math.max(Math.floor(UPower.displayDevice.percentage * 11), 0), 10)}.svg`

      height: parent.height - 8
      width: height
      anchors.centerIn: parent
      
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

  popup: RowLayout {
    spacing: 10
    
    Text {
      text: `${Math.round(UPower.displayDevice.percentage * 100)}%`
      color: UPower.displayDevice.percentage > 0.5
          ? Catppuccin.green
        : UPower.displayDevice.percentage > 0.35
          ? Catppuccin.yellow
        : UPower.displayDevice.percentage > 2 / 11 // the first two are red
          ? Catppuccin.peach
          : Catppuccin.red
      font.pixelSize: 24
      font.bold: true

      Layout.leftMargin: 10
      Layout.topMargin: 10
      Layout.bottomMargin: 10
    }
    
    ColumnLayout {
      Layout.rightMargin: 10
      
      Text {
        text: `${UPower.displayDevice.energy.toFixed(1)}/${UPower.displayDevice.energyCapacity.toFixed(1)} Wh`
        color: Catppuccin.text
      }
      
      Text {
        text: formatDuration()
        color: Catppuccin.text

        function formatDuration() {
          const time = UPower.onBattery ? UPower.displayDevice.timeToEmpty : UPower.displayDevice.timeToFull

          const timeString = time ? `${time > 3600 ? `${Math.floor(time / 3600)}h` : ''}${Math.floor((time % 3600) / 60)}m ` : ''
          const rateString = `(${UPower.onBattery ? '-' : '+'}${Math.round(UPower.displayDevice.changeRate)} W)`
          
          return timeString + rateString
        }
      }
    }
  }
}