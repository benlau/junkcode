import QtQuick 2.0

Item {
    id: component

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }

    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: mouseArea.pressed ? 0.3 : 0
    }

    Text {
        anchors.centerIn: parent
        text:  "Click me"
    }

}