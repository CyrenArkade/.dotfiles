pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import "../components"
import "../singletons"

BarWidget {
  id: root
  name: 'audio'

  bar: Item {
    implicitHeight: Config.barHeight
    implicitWidth: row.implicitWidth

    PwObjectTracker {
      objects: [Pipewire.defaultAudioSink]
    }

    RowLayout {
      id: row

      x: (parent.width - width) / 2
      spacing: 0
      
      Image {
        source: `../assets/audio/speaker${(!Pipewire.defaultAudioSink?.audio.muted && Pipewire.defaultAudioSink?.audio.volume) ? '' : '-muted'}.svg`
        Layout.margins: 4
        Layout.preferredHeight: Config.barHeight - 8
        Layout.preferredWidth: height
        sourceSize.height: height
        sourceSize.width: width
      }

      Text {
        text: Math.round(Pipewire.defaultAudioSink?.audio.volume * 100) + '%'
        color: Catppuccin.text
        Layout.rightMargin: 4
      }
    }

    // for gesture scrolling
    MouseArea {
      anchors.fill: parent
      onWheel: event => {
        let volume = Pipewire.defaultAudioSink.audio.volume + event.angleDelta.y * -0.00005
        volume = Math.min(Math.max(volume, 0), 1)
        Pipewire.defaultAudioSink.audio.volume = volume
      }
    }

    // for normal scrolling and clicks
    MouseArea {
      anchors.fill: parent
      acceptedButtons: Qt.LeftButton | Qt.RightButton
      cursorShape: Qt.PointingHandCursor
      scrollGestureEnabled: false
      onClicked: root.state = root.state === 'open' ? 'closed' : 'open'
      onWheel: event => {
        let volume = Pipewire.defaultAudioSink.audio.volume + 0.05 * Math.sign(event.angleDelta.y)
        volume = Math.round(volume * 20) / 20
        volume = Math.min(Math.max(volume, 0), 1)
        Pipewire.defaultAudioSink.audio.volume = volume
      }
    }
  }

  popup: ColumnLayout {
    PwNodeLinkTracker {
      id: linkTracker
      node: Pipewire.defaultAudioSink
    }

    AudioItem {
      node: Pipewire.defaultAudioSink
      name: Pipewire.defaultAudioSink.description
      icon: `../assets/audio/speaker${(!Pipewire.defaultAudioSink?.audio.muted && Pipewire.defaultAudioSink?.audio.volume) ? '' : '-muted'}.svg`
      bold: true
      Layout.topMargin: 10
    }

    // why this no work :(
    // PwObjectTracker {
    //   objects: [Pipewire.defaultAudioSource]
    // }
    // Text {
    //   text: [Pipewire.defaultAudioSource.name, Pipewire.defaultAudioSource.description, Pipewire.defaultAudioSource.nickname, Pipewire.defaultAudioSource.ready, Pipewire.defaultAudioSource.audio.volume].join('\n')
    //   color: Catppuccin.text
    // }
    // Timer {
    //   interval: 1000
    //   running: true
    //   repeat: true
    //   onTriggered: {
    //     Pipewire.defaultAudioSink.audio.volume = Pipewire.defaultAudioSink.audio.volume + 1 - 1
    //     console.log(Pipewire.defaultAudioSource.audio.volume)
    //   }
    // }
    // AudioItem {
    //   node: Pipewire.defaultAudioSource
    //   name: Pipewire.defaultAudioSource.description
    //   icon: '../assets/audio/microphone.svg'
    // }

    Repeater {
      model: linkTracker.linkGroups

      AudioItem {
        required property PwLinkGroup modelData
        node: modelData.source
      }
    }
  }
}