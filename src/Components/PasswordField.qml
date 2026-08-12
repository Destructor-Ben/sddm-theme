import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
  id: passwordField
  focus: true
  selectByMouse: true
  placeholderText: "Password"
  echoMode: TextInput.Password
  passwordCharacter: "•"
  passwordMaskDelay: config.PasswordShowLastLetter
  selectionColor: config.TextSelectionColor
  renderType: Text.NativeRendering
  font {
    family: config.Font
    pointSize: config.FontSize
    bold: true
  }
  color: config.TextColor
  placeholderTextColor: config.PlaceholderTextColor
  horizontalAlignment: TextInput.AlignHCenter
  leftPadding: height / 2
  rightPadding: height / 2
  cursorDelegate: Cursor { }
  background: Rectangle {
    id: passFieldBackground
    radius: height / 2
    color: config.TextFieldColor
  }
  states: [
    State {
      name: "focused"
      when: passwordField.activeFocus
      PropertyChanges {
        target: passFieldBackground
        color: config.TextFieldFocusedColor
      }
    },
    State {
      name: "hovered"
      when: passwordField.hovered
      PropertyChanges {
        target: passFieldBackground
        color: config.TextFieldHoverColor
      }
    }
  ]
  transitions: Transition {
    PropertyAnimation {
      properties: "color"
      duration: config.TransitionDuration
    }
  }
}
