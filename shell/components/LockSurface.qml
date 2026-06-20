pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls.Fusion
import QtQuick.Effects
import Quickshell.Wayland
import Quickshell.Widgets
import qs.singletons

WlSessionLockSurface {
  id: root

  signal tryUnlock()
  signal passwordTextChanged(text: string)

  required property string globalPasswordText
  required property bool locked
  required property bool unlocking
  required property real open

  onGlobalPasswordTextChanged: passwordField.text = globalPasswordText
  
  color: 'transparent'

  onUnlockingChanged: {
    if (!unlocking && locked)
      passwordIncorrectAnim.start()
  }

  ScreencopyView {
    captureSource: root.screen
    anchors.fill: parent
  }

  Rectangle {
    id: source
    layer.enabled: true
    layer.effect: MultiEffect {
      maskEnabled: true
      maskSource: mask
    }

    anchors.fill: parent
    
    Image {
      source: '/home/cyren/.dotfiles/images/xilmo4.jpg'
      anchors.fill: parent
    }

    ClippingWrapperRectangle {
      id: user
      
      x: (parent.width - width) / 2
      y: (parent.height - height) / 2
      height: 100 + 2 * border.width
      width: height
      radius: height / 2
      opacity: root.open
      scale: 1 - 0.1 * (1 - root.open)

      contentInsideBorder: true
      border {
        width: 4 + passwordField.text.length
        color: [
          Catppuccin.red,
          Catppuccin.peach,
          Catppuccin.yellow,
          Catppuccin.green,
          Catppuccin.sky,
          Catppuccin.blue,
          Catppuccin.lavender,
          Catppuccin.mauve,
        ][passwordField.text.length % 8]
        Behavior on color { ColorAnimation { duration: 200; easing.type: Easing.OutQuad } }
      }
      
      Image {
        source: '/home/cyren/.dotfiles/images/icon.jpg'
      }

      SequentialAnimation {
        id: passwordIncorrectAnim
        alwaysRunToEnd: true
        
        NumberAnimation { target: user; property: "rotation"; to: -10; duration: 50;  easing.type: Easing.InOutSine }
        NumberAnimation { target: user; property: "rotation"; to: 7.5; duration: 100; easing.type: Easing.InOutSine }
        NumberAnimation { target: user; property: "rotation"; to:  -5; duration: 100; easing.type: Easing.InOutSine }
        NumberAnimation { target: user; property: "rotation"; to: 2.5; duration: 100; easing.type: Easing.InOutSine }
        NumberAnimation { target: user; property: "rotation"; to:   0; duration: 50;  easing.type: Easing.InOutSine }
      }
    }

    TextField {
      id: passwordField
      
      echoMode: TextInput.Password
      inputMethodHints: Qt.ImhHiddenText | Qt.ImhSensitiveData
      visible: false
      focus: true
      readOnly: root.unlocking
      
      onTextChanged: root.passwordTextChanged(text)
      onAccepted: root.tryUnlock()

      onActiveFocusChanged: {
        if (!activeFocus)
          passwordField.forceActiveFocus()
      }
    }
  }

  Item {
    id: mask
    layer.enabled: true
    visible: false

    anchors.fill: parent

    Rectangle {
      width: Math.sqrt(Math.pow(root.width, 2) + Math.pow(root.height, 2)) * root.open
      height: width
      x: (root.width - width) / 2
      y: (root.height - height) / 2
      radius: Math.max(root.width, root.height) / 2
    }
  }
}