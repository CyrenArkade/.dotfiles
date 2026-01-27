pragma Singleton

import Quickshell
import QtQuick

Singleton {
  readonly property int barHeight: 30
  
  readonly property QtObject colors: QtObject {
    readonly property color text: Catppuccin.text

    readonly property color barBg: Catppuccin.base
    readonly property color barBorder: Catppuccin.surface0
  }
}