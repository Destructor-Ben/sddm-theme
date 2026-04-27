import QtQuick 2.15
import Qt5Compat.GraphicalEffects

// TODO: make look like Pop2
// - text stroke
// - coloured shadow
Item {
  id: time
  property date dateTime: new Date()
  property color color: config.ClockColor

  anchors {
    topMargin: config.ClockTopMargin
    bottomMargin: config.ClockBottomMargin
    leftMargin: config.ClockLeftMargin
    rightMargin: config.ClockRightMargin

    top: config.ClockVerticalAnchor === "top" ? parent.top : undefined
    bottom: config.ClockVerticalAnchor === "bottom" ? parent.bottom : undefined
    verticalCenter: config.ClockVerticalAnchor === "center" ? parent.verticalCenter : undefined

    left: config.ClockHorizontalAnchor === "left" ? parent.left : undefined
    right: config.ClockHorizontalAnchor === "right" ? parent.right : undefined
    horizontalCenter: config.ClockHorizontalAnchor === "center" ? parent.horizontalCenter : undefined
  }

  Timer {
    interval: 100; running: true; repeat: true;
    onTriggered: time.dateTime = new Date()
  }

  Text {
    id: dateText

    anchors {
      left: config.ClockHorizontalAnchor === "left" ? parent.left : undefined
      right: config.ClockHorizontalAnchor === "right" ? parent.right : undefined
      horizontalCenter: config.ClockHorizontalAnchor === "center" ? parent.horizontalCenter : undefined

      top: config.ClockVerticalAnchor === "top" ? parent.top : undefined

      bottom: config.ClockVerticalAnchor === "bottom" ? timeText.top : (config.ClockVerticalAnchor === "center" ? parent.verticalCenter : undefined)
      bottomMargin: config.ClockVerticalAnchor === "bottom" ? config.ClockGap : (config.ClockVerticalAnchor === "center" ? (config.ClockGap / 2) : undefined)
    }

    color: time.color
    text : (config.ClockSwapDateAndTime == "true") ? Qt.formatTime(time.dateTime, config.ClockTimeFormat) : Qt.formatDate(time.dateTime, config.ClockDateFormat)
    font.family: config.ClockFont
    font.pointSize: (config.ClockSwapDateAndTime == "true") ? config.ClockTimeSize : config.ClockDateSize
  }

  Text {
    id: timeText

    anchors {
      left: config.ClockHorizontalAnchor === "left" ? parent.left : undefined
      right: config.ClockHorizontalAnchor === "right" ? parent.right : undefined
      horizontalCenter: config.ClockHorizontalAnchor === "center" ? parent.horizontalCenter : undefined

      top: config.ClockVerticalAnchor === "top" ? dateText.bottom : (config.ClockVerticalAnchor === "center" ? parent.verticalCenter : undefined)
      topMargin: config.ClockVerticalAnchor === "top" ? config.ClockGap : (config.ClockVerticalAnchor === "center" ? (config.ClockGap / 2) : undefined)

      bottom: config.ClockVerticalAnchor === "bottom" ? parent.bottom : undefined
    }

    color: time.color
    text : (config.ClockSwapDateAndTime == "true") ? Qt.formatDate(time.dateTime, config.ClockDateFormat) : Qt.formatTime(time.dateTime, config.ClockTimeFormat)
    font.family: config.ClockFont
    font.pointSize: (config.ClockSwapDateAndTime == "true") ? config.ClockDateSize : config.ClockTimeSize
  }

  DropShadow {
    visible: config.ClockShadow == "true"
    anchors.fill: dateText
    source: dateText

    // TODO: clock shadow settings
    horizontalOffset: config.LargeShadowOffset
    verticalOffset: config.LargeShadowOffset
    radius: config.LargeShadowRadius
    samples: config.ShadowSamples
    color: config.ShadowColor
  }

  DropShadow {
    visible: config.ClockShadow == "true"
    anchors.fill: timeText
    source: timeText

    // TODO: clock shadow settings
    horizontalOffset: config.LargeShadowOffset
    verticalOffset: config.LargeShadowOffset
    radius: config.LargeShadowRadius
    samples: config.ShadowSamples
    color: config.ShadowColor
  }
}
