pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Io
import Quickshell.Services.Pam
import Quickshell.Wayland
import qs.components

Item {
  id: root

  property bool locked
  property bool unlocking
  property string passwordText
  property real open: 0

  Behavior on open { id: openBehavior; NumberAnimation { duration: 400; easing { type: Easing.OutSine } } }

  function lock() {
    root.passwordText = ''
    root.locked = true
  }
  function unsafeUnlock() {
    root.locked = false
    root.open = 0
  }

  PamContext {
    id: pam

    onPamMessage: {
			if (this.responseRequired)
				this.respond(root.passwordText)
		}

    onCompleted: result => {
			if (result == PamResult.Success) {
        root.unsafeUnlock() // SAFE: went through pam
      }
			else
				root.passwordText = ""

			root.unlocking = false
		}
  }

  WlSessionLock {
    id: lock

    locked: root.locked || root.open > 0

    LockSurface {
      id: lockSurface
      locked: root.locked
      unlocking: root.unlocking
      globalPasswordText: root.passwordText
      open: root.open
      
      onPasswordTextChanged: text => root.passwordText = text
      onTryUnlock: {
        root.unlocking = true
        pam.start()
      }

      Component.onCompleted: root.open = 1
    }
  }

  IpcHandler {
    target: 'lockscreen'

    function lock() {
      root.lock()
    }
    function lockImmediate() {
      openBehavior.enabled = false
      root.open = 1
      openBehavior.enabled = true
      root.lock()
    }
    function unlock() {
      root.unsafeUnlock() // SAFE: accessing IPC requires auth
    }
  }
}