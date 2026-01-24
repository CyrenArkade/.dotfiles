pragma Singleton

import Quickshell
import QtQuick

Singleton {
  readonly property string time: {
    Qt.formatDateTime(clock.date, "MMM d  hh:mm")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}