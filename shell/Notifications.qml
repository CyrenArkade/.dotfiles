import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications 
import './singletons'

PanelWindow {
  anchors {
    bottom: true
    right: true
  }

  margins {
    bottom: 17
    right: 17
  }

  implicitHeight: listView.implicitHeight
  implicitWidth: listView.implicitWidth

  NotificationServer {
    id: server
    onNotification: n => n.tracked = true
  }

  Rectangle {
    anchors.fill: parent
    
    color: Config.barColorBg
    border {
      width: 1
      color: Config.barColorBorder
    }

    ListView {
      id: listView
      anchors.fill: parent

      implicitWidth: 200
      implicitHeight: 200

      model: server.trackedNotifications
      delegate: ColumnLayout {
        id: notif
        required property Notification modelData

        clip: true
        
        Text {
          text: notif.modelData.summary
          color: Catppuccin.text
        }
        Text {
          text: notif.modelData.body
          color: Catppuccin.text
          width: 100
        }
      }
    }

  }
}