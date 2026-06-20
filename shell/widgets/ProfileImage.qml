import QtQuick
import QtQuick.Layouts
import qs.singletons

Item {
  Layout.preferredHeight: Config.barHeight
  Layout.preferredWidth: Config.barHeight
  Layout.alignment: Qt.AlignBottom

  Image {
    source: "../assets/strawberry.svg"

    width: parent.width
    height: parent.height

    sourceSize.width: width
    sourceSize.height: height
  }
}