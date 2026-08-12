import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15

Item {
  property var session: sessionList.currentIndex
  implicitHeight: sessionButton.height
  implicitWidth: sessionButton.width
  DelegateModel {
    id: sessionWrapper
    model: sessionModel
    delegate: ItemDelegate {
      id: sessionEntry
      width: parent.width
      height: config.SessionSelectorItemHeight
      highlighted: sessionList.currentIndex == index
      contentItem: Text {
        id: sessionEntryText
        renderType: Text.NativeRendering
        font {
          family: config.Font
          pointSize: config.FontSize
          bold: true
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: config.SessionSelectorItemTextColor
        text: name
      }
      background: Rectangle {
        id: sessionEntryBackground
        color: config.SessionSelectorItemColor
        radius: height / 2
      }
      states: [
        State {
          name: "selected"
          when: sessionList.currentIndex == index
          PropertyChanges {
            target: sessionEntryBackground
            color: config.SessionSelectorItemColorSelected
          }
          PropertyChanges {
            target: sessionEntryText
            color: config.SessionSelectorItemTextColorSelected
          }
        },
        State {
          name: "hovered"
          when: sessionEntry.hovered
          PropertyChanges {
            target: sessionEntryBackground
            color: config.SessionSelectorItemColorHover
          }
          PropertyChanges {
            target: sessionEntryText
            color: config.SessionSelectorItemTextColorHover
          }
        }
      ]
      transitions: Transition {
        PropertyAnimation {
          property: "color"
          duration: config.TransitionDuration
        }
      }
      MouseArea {
        anchors.fill: parent
        onClicked: {
          sessionList.currentIndex = index
          sessionPopup.close()
        }
      }
    }
  }
  Button {
    id: sessionButton
    height: config.SessionSelectorIconSize
    width: config.SessionSelectorIconSize
    hoverEnabled: true
    icon {
      source: Qt.resolvedUrl(config.UseCustomSessionSelectorIcon == "true" ? config.SessionSelectorIcon : "../assets/settings.svg")
      height: height
      width: width
      color: config.SessionSelectorIconColor
    }
    background: Rectangle {
      id: sessionButtonBackground
      radius: config.CircularSessionSelector == "true" ? sessionButton.height / 2 : config.SessionSelectorBorderRadius
      color: config.SessionSelectorColor
    }
    states: [
      State {
        name: "pressed"
        when: sessionButton.down
        PropertyChanges {
          target: sessionButtonBackground
          color: config.SessionSelectorPressedColor
        }
        PropertyChanges {
          target: sessionButton
          icon.color: config.SessionSelectorPressedIconColor
        }
      },
      State {
        name: "hovered"
        when: sessionButton.hovered
        PropertyChanges {
          target: sessionButtonBackground
          color: config.SessionSelectorHoverColor
        }
        PropertyChanges {
          target: sessionButton
          icon.color: config.SessionSelectorHoverIconColor
        }
      }
    ]
    transitions: Transition {
      PropertyAnimation {
        properties: "color"
        duration: config.TransitionDuration
      }
    }
    onClicked: {
      sessionPopup.visible ? sessionPopup.close() : sessionPopup.open()
      sessionButton.state = "pressed"
    }
  }
  Popup {
    id: sessionPopup
    x: -width + sessionButton.width
    y: -height - padding
    padding: config.Spacing
    // The * 1 is crucial, no idea why, but without it, the width is * 10
    width: config.SessionSelectorItemWidth * 1 + padding * 2
    background: Rectangle {
      radius: config.SessionSelectorPopupRadius
      color: config.SessionSelectorPopupColor
    }
    contentItem: ListView {
      id: sessionList
      implicitHeight: contentHeight
      spacing: config.Spacing
      model: sessionWrapper
      currentIndex: sessionModel.lastIndex
      clip: true
    }
    enter: Transition {
      ParallelAnimation {
        NumberAnimation {
          property: "opacity"
          from: 0
          to: 1
          duration: config.TransitionDuration * 2
          easing.type: Easing.OutExpo
        }
      }
    }
    exit: Transition {
      NumberAnimation {
        property: "opacity"
        from: 1
        to: 0
        duration: config.TransitionDuration * 2
        easing.type: Easing.OutExpo
      }
    }
  }
}
