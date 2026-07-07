pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import "../components"
import "../singletons"

Loader {
  id: root
  required property PwNode node

  property string name: ''
  property string icon: ''
  property bool bold: false

  Layout.fillWidth: true

  PwObjectTracker {
    objects: [root.node]
  }

  active: node.ready

  sourceComponent: RowLayout {

    implicitWidth: slider.implicitWidth
    implicitHeight: slider.implicitHeight
    Layout.fillWidth: true

    Image {
      // glitchy on first run, so it's in a function.
      // somehow binding heuristicLookup stops it from being null.
      source: {
        const entry = DesktopEntries.heuristicLookup(root.node.name)
        return root.icon || Quickshell.iconPath(entry.icon, true)
      }

      Layout.preferredHeight: Config.barHeight
      Layout.preferredWidth: height
      Layout.leftMargin: 5
      
      sourceSize.height: height
      sourceSize.width: width

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.node.audio.muted ^= true 
      }
    }

    ColumnLayout {
      spacing: 0
      Layout.rightMargin: 10
      Layout.fillWidth: true
      
      RowLayout {
        Text {
          text: root.name || root.node.name
          color: Catppuccin.text
          font.bold: root.bold
          Layout.fillWidth: true
        }

        Text {
          text: `${Math.round(root.node.audio.volume * 100)}%`
          color: Catppuccin.text
        }
      }
      
      CustomSlider {
        id: slider
        value: root.node.audio.volume
        dead: root.node.audio.muted
        onValueChanged: root.node.audio.volume = value
        Layout.fillWidth: true
      }
    }
  }
}
