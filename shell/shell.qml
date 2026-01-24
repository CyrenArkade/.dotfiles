//@ pragma UseQApplication

import QtQuick
import Quickshell

Scope {
  Lock { }
  
  Variants {
    model: Quickshell.screens

    Item {
      required property ShellScreen modelData
      
      Bar {
        screen: modelData
      }
      // Notifications {
      //   screen: modelData
      // }
    }
  }
}