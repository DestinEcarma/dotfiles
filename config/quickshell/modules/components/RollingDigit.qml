import QtQuick

import qs.config

Item {
    id: root

    required property int value
    property alias font: currentText.font
    property alias color: currentText.color

    property int _previousValue: value

    implicitWidth: currentText.implicitWidth
    implicitHeight: currentText.implicitHeight
    clip: true

    StyledText {
        id: previousText
        anchors.horizontalCenter: parent.horizontalCenter
        text: root._previousValue
        font: currentText.font
        color: currentText.color
        y: 0
    }

    StyledText {
        id: currentText
        anchors.horizontalCenter: parent.horizontalCenter
        text: root.value
        y: root.height
    }

    onValueChanged: {
        if (value === _previousValue)
            return;

        previousText.text = _previousValue;
        previousText.y = 0;
        currentText.text = value;
        currentText.y = root.height;

        rollAnimation.start();
    }

    ParallelAnimation {
        id: rollAnimation

        NumberAnimation {
            target: previousText
            property: "y"
            to: -root.height
            duration: Config.animationSlow
            easing.type: Config.easingEmphasized
        }

        NumberAnimation {
            target: currentText
            property: "y"
            to: 0
            duration: Config.animationSlow
            easing.type: Config.easingEmphasized
        }

        onRunningChanged: previousText.visible = rollAnimation.running
        onFinished: root._previousValue = root.value
    }
}
