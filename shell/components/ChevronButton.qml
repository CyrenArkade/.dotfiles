import QtQuick
import QtQuick.Layouts
import '../singletons'

Rectangle {
  id: root
  required property string direction
  
  signal clicked(MouseEvent event)
  
  Layout.preferredHeight: 32
  Layout.preferredWidth: 32
  
  color: mouseArea.containsMouse ? Catppuccin.withAlpha(Catppuccin.lavender, 0.2) : 'transparent'
  
  Image {
    id: img
    source: Config.asset(`chevron/${root.direction}.svg`)
    readonly property int margin: 4
    height: parent.height - margin * 2
    width: height
    y: margin
    anchors.horizontalCenter: parent.horizontalCenter
    sourceSize.width: width
    sourceSize.height: height

    SequentialAnimation {
      id: hoverAnim
      running: false
      NumberAnimation { target: img; property: "scale"; to: 1.2; duration: 120; easing.type: Easing.OutQuad }
      NumberAnimation { target: img; property: "scale"; to: 0.9; duration: 120; easing.type: Easing.InOutQuad }
      NumberAnimation { target: img; property: "scale"; to: 1.0; duration: 120; easing.type: Easing.OutBounce }
    }
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: event => root.clicked(event)
    onHoveredChanged: {
      if (containsMouse)
        hoverAnim.running = true
    }
  }
}