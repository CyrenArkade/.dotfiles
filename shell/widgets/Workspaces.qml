pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Widgets
import qs.singletons

WrapperRectangle {
  Layout.preferredHeight: Config.barHeight

  color: Config.colors.barBg
  border {
    width: 1
    color: Config.colors.barBorder
  }

  RowLayout {
    spacing: 0
    
    Repeater {
      id: r
      model: Hyprland.workspaces.values
        .slice()
        .filter(ws => !ws.name.endsWith('quake'))
        .sort((a, b) => Math.abs(a.id) - Math.abs(b.id))

      WrapperMouseArea {
        id: ma
        required property int index
        required property HyprlandWorkspace modelData
        property HyprlandWorkspace workspace: modelData

        Layout.fillHeight: true

        leftMargin: ma.index == 0 ? 11 : 4
        rightMargin: ma.index == r.count-1 ? 11 : 4

        resizeChild: false

        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${ma.workspace.name} })`)

        Loader {
          readonly property Component special: ClippingWrapperRectangle {

            topMargin: 1
            bottomMargin: 1
            leftMargin: 4
            rightMargin: 4

            color: Catppuccin.lavender
            radius: 100
            
            Text {
              text: ma.workspace.name.slice(8)
              color: Catppuccin.base
              verticalAlignment: Text.AlignVCenter
              font.bold: true
            }
          }

          readonly property Component numeric: Rectangle {
            id: wsIndicator
            implicitWidth: 16
            implicitHeight: 16
            color: Catppuccin.lavender
            radius: ma.workspace.focused || ma.containsMouse ? 2 : 8

            Behavior on radius { NumberAnimation { duration: 150 } }

            states: [
              State { name: "unfocused"; when: !ma.workspace.focused; PropertyChanges { wsIndicator.scale: 0.75 } },
              State { name: "focused";   when: ma.workspace.focused;  PropertyChanges { wsIndicator.scale: 1    } },
            ]

            transitions: [
              Transition {
                from: "focused"; to: "unfocused"
                NumberAnimation { target: wsIndicator; property: "scale"; duration: 100; }
              },
              Transition {
                from: "unfocused"; to: "focused"
                SequentialAnimation {
                  NumberAnimation { target: wsIndicator; property: "scale"; to: 1.2; duration: 120; easing.type: Easing.OutQuad }
                  NumberAnimation { target: wsIndicator; property: "scale"; to: 0.9; duration: 120; easing.type: Easing.InOutQuad }
                  NumberAnimation { target: wsIndicator; property: "scale"; to: 1.0; duration: 120; easing.type: Easing.OutBounce }
                }
              },
            ]
          }

          sourceComponent: ma.workspace ? (ma.workspace.id < 0 ? special : numeric) : undefined
        }
      }
    }
  }
}
