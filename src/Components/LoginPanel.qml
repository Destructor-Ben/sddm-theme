import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects
import "../assets"

Item {
  property var user: userField.text
  property var password: passwordField.text
  property var session: sessionPanel.session
  property var inputHeight: config.LoginPanelFieldHeight
  property var inputWidth: config.LoginPanelFieldWidth

  Rectangle {
    id: loginBackground
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }
    radius: config.LoginPanelBorderRadius
    color: config.LoginPanelColor
    width: loginContents.width + config.LoginPanelPadding * 2
    height: loginContents.height + config.LoginPanelPadding * 2
    border.width: config.LoginPanelBorderWidth
    border.color: config.LoginPanelBorderColor

    Column {
      id: loginContents
      spacing: config.Spacing
      z: 5
      anchors {
        verticalCenter: parent.verticalCenter
        horizontalCenter: parent.horizontalCenter
        margins: config.LoginPanelPadding
      }
      // fake padding
      Item {
        visible: config.UserIcon == "true"
        width: 1
        height: config.Spacing
      }
      Rectangle {
        visible: config.UserIcon == "true"
        width: config.UserIconSize
        height: config.UserIconSize
        color: "transparent"
        Image {
          source: config.DefaultUserIcon ? config.DefaultUserIcon : Qt.resolvedUrl("../assets/defaultIcon.png")
          height: parent.width
          width: parent.width
        }
        Image {
          // common icon path for KDE and GNOME
          source: Qt.resolvedUrl("/var/lib/AccountsService/icons/" + user)
          height: parent.width
          width: parent.width
        }
        Image {
          source: Qt.resolvedUrl("../assets/mask.svg")
          height: parent.width
          width: parent.width

          layer.enabled: true
          layer.effect: ColorOverlay {
              color: config.LoginPanelColor
          }
        }
        Image {
          source: Qt.resolvedUrl("../assets/ring.svg")
          height: parent.width
          width: parent.width

          layer.enabled: true
          layer.effect: ColorOverlay {
              color: config.UserIconBorderColor
          }
        }
        anchors {
          horizontalCenter: parent.horizontalCenter
        }
      }
      // fake padding
      Item {
        visible: config.UserIcon == "true"
        width: 1
        height: config.Spacing
      }
      UserField {
        id: userField
        width: inputWidth
        height: inputHeight
      }
      PasswordField {
        id: passwordField
        width: inputWidth
        height: inputHeight
        onAccepted: loginButton.clicked()
      }
      Button {
        id: loginButton
        width: inputWidth
        height: inputHeight
        enabled: user != "" && password != "" ? true : false
        hoverEnabled: true
        contentItem: Text {
          id: buttonText
          renderType: Text.NativeRendering
          font {
            family: config.Font
            pointSize: config.FontSize
            bold: true
          }
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          color: config.LoginButtonTextColor
          text: "Login"
        }
        background: Rectangle {
          id: buttonBackground
          color: config.LoginButtonColor
          radius: height / 2
        }
        states: [
          State {
            name: "pressed"
            when: loginButton.down
            PropertyChanges {
              target: buttonBackground
              color: config.LoginButtonPressedColor
            }
            PropertyChanges {
              target: buttonText
              color: config.LoginButtonPressedTextColor
            }
          },
          State {
            name: "hovered"
            when: loginButton.hovered
            PropertyChanges {
              target: buttonBackground
              color: config.LoginButtonHoverColor
            }
            PropertyChanges {
              target: buttonText
              color: config.LoginButtonHoverTextColor
            }
          },
          State {
            name: "enabled"
            when: loginButton.enabled
            PropertyChanges {
              target: buttonBackground
            }
            PropertyChanges {
              target: buttonText
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
          sddm.login(user, password, session)
          // For debugging
          // connections.onLoginFailed()
        }
      }
    }
  }
  DropShadow {
    anchors.fill: loginBackground
    source: loginBackground

    color: config.LoginPanelShadowColor
    samples: config.LoginPanelShadowSamples
    radius: config.LoginPanelShadowRadius
    horizontalOffset: config.LoginPanelShadowXOffset
    verticalOffset: config.LoginPanelShadowYOffset
  }

  SequentialAnimation {
    id: loginFailedAnimation
    running: false

    ScriptAction {
      script: {
        passwordField.placeholderText = config.LoginFailedMessage
        passwordField.placeholderTextColor = config.LoginFailedTextColor
      }
    }
    NumberAnimation { from: config.LoginFailedAnimAmplitude * 0; to: -1 * config.LoginFailedAnimAmplitude; target: loginBackground; property: "anchors.horizontalCenterOffset"; easing.type: Easing.InOutQuad; duration: config.LoginFailedAnimSpeed }
    NumberAnimation { from: config.LoginFailedAnimAmplitude * -1; to: 2 * config.LoginFailedAnimAmplitude; target: loginBackground; property: "anchors.horizontalCenterOffset"; easing.type: Easing.InOutQuad; duration: config.LoginFailedAnimSpeed }
    NumberAnimation { from: config.LoginFailedAnimAmplitude * 2; to: -4 * config.LoginFailedAnimAmplitude; target: loginBackground; property: "anchors.horizontalCenterOffset"; easing.type: Easing.InOutQuad; duration: config.LoginFailedAnimSpeed }
    NumberAnimation { from: config.LoginFailedAnimAmplitude * -4; to: 4 * config.LoginFailedAnimAmplitude; target: loginBackground; property: "anchors.horizontalCenterOffset"; easing.type: Easing.InOutQuad; duration: config.LoginFailedAnimSpeed }
    NumberAnimation { from: config.LoginFailedAnimAmplitude * 4; to: -4 * config.LoginFailedAnimAmplitude; target: loginBackground; property: "anchors.horizontalCenterOffset"; easing.type: Easing.InOutQuad; duration: config.LoginFailedAnimSpeed }
    NumberAnimation { from: config.LoginFailedAnimAmplitude * -4; to: 4 * config.LoginFailedAnimAmplitude; target: loginBackground; property: "anchors.horizontalCenterOffset"; easing.type: Easing.InOutQuad; duration: config.LoginFailedAnimSpeed }
    NumberAnimation { from: config.LoginFailedAnimAmplitude * 4; to: -4 * config.LoginFailedAnimAmplitude; target: loginBackground; property: "anchors.horizontalCenterOffset"; easing.type: Easing.InOutQuad; duration: config.LoginFailedAnimSpeed }
    NumberAnimation { from: config.LoginFailedAnimAmplitude * -4; to: 2 * config.LoginFailedAnimAmplitude; target: loginBackground; property: "anchors.horizontalCenterOffset"; easing.type: Easing.InOutQuad; duration: config.LoginFailedAnimSpeed }
    NumberAnimation { from: config.LoginFailedAnimAmplitude * 2; to: -1 * config.LoginFailedAnimAmplitude; target: loginBackground; property: "anchors.horizontalCenterOffset"; easing.type: Easing.InOutQuad; duration: config.LoginFailedAnimSpeed }
    NumberAnimation { from: config.LoginFailedAnimAmplitude * -1; to: 0 * config.LoginFailedAnimAmplitude; target: loginBackground; property: "anchors.horizontalCenterOffset"; easing.type: Easing.InOutQuad; duration: config.LoginFailedAnimSpeed }
    PauseAnimation { duration: config.IncorrectPasswordDelay }
    ScriptAction {
      script: {
        passwordField.placeholderText = "Password"
        passwordField.placeholderTextColor = config.PlaceholderTextColor
        passwordField.focus = true
      }
    }
  }

  Connections {
    id: connections
    target: sddm

    function onLoginFailed() {
      passwordField.text = ""
      passwordField.focus = false

      if (!loginFailedAnimation.running && config.EnableLoginFailedAnimation == "true") {
        loginFailedAnimation.start()
      }
    }
  }
}
