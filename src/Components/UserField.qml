import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
  id: userField
  text: userModel.lastUser
  selectByMouse: true
  placeholderText: "Username"
  echoMode: TextInput.Normal
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
    id: userFieldBackground
    radius: height / 2
    color: config.TextFieldColor
  }
  states: [
    State {
      name: "focused"
      when: userField.activeFocus
      PropertyChanges {
        target: userFieldBackground
        color: config.TextFieldFocusedColor
      }
    },
    State {
      name: "hovered"
      when: userField.hovered
      PropertyChanges {
        target: userFieldBackground
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
