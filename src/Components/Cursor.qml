import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
  id: cursorRect

  x: parent.cursorRectangle.x
  y: parent.cursorRectangle.y
  height: parent.cursorRectangle.height

  width: 2
  radius: width / 2
  color: parent.color
  visible: parent.cursorVisible

  SequentialAnimation {
      loops: Animation.Infinite
      running: parent.cursorVisible && config.ShouldBlinkCursor == "true"

      PropertyAnimation { duration: config.CursorBlinkDuration / 2 }
      ScriptAction { script: cursorRect.opacity = 0.0 }
      PropertyAnimation { duration: config.CursorBlinkDuration / 2 }
      ScriptAction { script: cursorRect.opacity = 1.0 }
  }
}
