pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import "../singletons"

Rectangle {
  id: root
  required property string name
  required property Component popup
  required property Component bar

  readonly property int animationDuration: 500

  property bool initializing: true
  Component.onCompleted: initializing = false

  property alias popupOpacity: popupLoader.opacity

  Layout.alignment: Qt.AlignBottom
  color: Config.barColorBg
  border {
    width: 1
    color: Config.barColorBorder
  }
  clip: true

  state: 'closed'
  states: [
    State {
      name: "open"
      PropertyChanges {
        restoreEntryValues: false
        popupLoader.opacity: 1
        popupLoader.showPopup: true
        root.implicitWidth: Math.max(barLoader.implicitWidth, popupLoader.implicitWidth)
        root.implicitHeight: barLoader.implicitHeight + popupLoader.implicitHeight
      }
      StateChangeScript {
        script: BarWidgetManager.openWidget = root.name
      }
    },
    State {
      name: "closed"
      PropertyChanges {
        restoreEntryValues: false
        popupLoader.opacity: 0
        root.implicitWidth: barLoader.implicitWidth
        root.implicitHeight: barLoader.implicitHeight
      }
      StateChangeScript {
        script: {
          if (root.initializing)
            return
          BarWidgetManager.closingWidget = true
          if (BarWidgetManager.openWidget == root.name)
            BarWidgetManager.openWidget = undefined
        }
      }
    },
  ]

  Behavior on implicitWidth  { NumberAnimation { duration: root.animationDuration; easing { type: Easing.OutBounce; amplitude: 0.2 } } }
  Behavior on implicitHeight { NumberAnimation { duration: root.animationDuration; easing { type: Easing.OutBounce; amplitude: 0.2 } } }

  MouseArea {
    anchors.fill: parent
  }

  Loader {
    id: popupLoader
    
    property bool showPopup: false
    opacity: 0
    Behavior on opacity { SequentialAnimation {
      NumberAnimation { duration: root.animationDuration; easing.type: Easing.OutQuart }
      PropertyAction { target: popupLoader; property: 'showPopup'; value: root.state === 'open' }
      PropertyAction { target: BarWidgetManager; property: 'closingWidget'; value: false }
    }}

    scale: Math.min(1, root.width / width)
    transformOrigin: Item.TopLeft
    x: (root.width - width * scale) / 2
    y: Math.max(0, (root.height - height * scale - barLoader.height) / 2)

    sourceComponent: showPopup ? root.popup : undefined
  }

  Loader {
    id: barLoader
    sourceComponent: root.bar
    
    width: parent.width
    height: Config.barHeight

    y: root.height - height
  }

  Connections {
    target: BarWidgetManager
    function onOpenWidgetChanged() {
      if (root.name !== BarWidgetManager.openWidget && root.state === 'open')
        root.state = 'closed'
    }
  }
}