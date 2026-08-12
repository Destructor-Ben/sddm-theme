import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
  id: root

  implicitHeight: powerButton.height
  implicitWidth: powerButton.width

  property var icon: ""
  signal action

  Button {
    id: powerButton
    height: config.PowerButtonIconSize
    width: config.PowerButtonIconSize
    hoverEnabled: true
    onClicked: root.action()

    icon {
      source: Qt.resolvedUrl(root.icon)
      height: height
      width: width
      color: config.PowerButtonIconColor
    }

    background: Rectangle {
      id: powerButtonBackground
      radius: config.CircularPowerButtons ? powerButton.height / 2 : config.PowerButtonBorderRadius
      color: config.PowerButtonColor
    }
    states: [
      State {
        name: "hovered"
        when: powerButton.hovered
        PropertyChanges {
          target: powerButtonBackground
          color: config.PowerButtonHoverColor
        }
        PropertyChanges {
          target: powerButton
          icon.color: config.PowerButtonHoverIconColor
        }
      }
    ]
    transitions: Transition {
      PropertyAnimation {
        target: powerButtonBackground
        properties: "color"
        duration: config.TransitionDuration
      }
      PropertyAnimation {
        target: powerButton
        properties: "icon.color"
        duration: config.TransitionDuration
      }
    }
  }
}
