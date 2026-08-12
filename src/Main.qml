import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "Components"

Item {
  id: root
  height: Screen.height
  width: Screen.width
  Rectangle {
    id: background
    anchors.fill: parent
    height: parent.height
    width: parent.width
    z: 0
    color: config.BackgroundColor
  }
  Image {
    id: backgroundImage
    anchors.fill: parent
    height: parent.height
    width: parent.width
    fillMode: Image.PreserveAspectCrop
    visible: config.CustomBackground == "true"
    z: 1
    source: config.Background
    asynchronous: false
    cache: true
    mipmap: true
    clip: true
  }
  Item {
    id: mainPanel
    z: 3
    anchors {
      fill: parent
      margins: config.Padding
    }
    Clock {
      id: time
      visible: config.ClockEnabled == "true"
    }
    LoginPanel {
      id: loginPanel
      anchors.fill: parent
    }
    Column {
      spacing: config.Spacing
      anchors {
        bottom: parent.bottom
        left: parent.left
      }
      PowerButton {
        id: sleepButton
        icon: config.UseCustomSleepIcon == "true" ? config.SleepIcon : "../assets/sleep.svg"
        onAction: sddm.suspend()
      }
      PowerButton {
        id: rebootButton
        icon: config.UseCustomRebootIcon == "true" ? config.RebootIcon : "../assets/reboot.svg"
        onAction: sddm.reboot()
      }
      PowerButton {
        id: powerButton
        icon: config.UseCustomPowerOffIcon == "true" ? config.PowerOffIcon : "../assets/power.svg"
        onAction: sddm.powerOff()
      }
      z: 5
    }
    Column {
      spacing: config.Spacing
      anchors {
        bottom: parent.bottom
        right: parent.right
      }
      SessionPanel {
        id: sessionPanel
      }
      z: 5
    }
  }
}
