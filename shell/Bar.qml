import QtQuick
import QtQuick.Layouts
import Quickshell

import "./singletons"
import "./widgets"

PanelWindow {
  id: window
  
  anchors {
    bottom: true
    left: true
    right: true
  }

  exclusiveZone: bar.height + 3
  implicitHeight: screen.height

  mask: Region {
    item: BarWidgetManager.openWidget ? window.contentItem : bar
  }
  aboveWindows: !!BarWidgetManager.openWidget || BarWidgetManager.closingWidget

  color: 'transparent'

  MouseArea {
    anchors.fill: parent
    onClicked: BarWidgetManager.openWidget = undefined
  }

  Item {
    id: bar

    anchors {
      bottom: parent.bottom
      left: parent.left
      right: parent.right
      bottomMargin: 8
      leftMargin: 14
      rightMargin: 14
    }

    implicitHeight: Config.barHeight

    RowLayout {
      id: right
      anchors {
        left: parent.left
        bottom: parent.bottom
      }
      ProfileImage {}
    }
    
    RowLayout {
      id: center
      anchors {
        horizontalCenter: parent.horizontalCenter
        bottom: parent.bottom
      }
      spacing: 0
      Workspaces {}
    }

    RowLayout {
      id: left
      anchors {
        right: parent.right
        bottom: parent.bottom
      }
      Tray {}
      Audio {}
      Battery {}
      Power {}
      Clock {}
    }
  }
}
