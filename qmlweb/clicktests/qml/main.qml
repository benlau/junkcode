import QtQuick 2.0

Item {
    id: component

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            console.log("clicked");
            console.log(mask.width, mask.height);
            console.log(mask.opacity);
        }
    }

    Rectangle {
        id: mask
        anchors.fill: parent
        color: "black"
        opacity: mouseArea.pressed ? 0.4 : 0.1
    }

    Text {
        anchors.centerIn: parent
        text:  "Click me"
    }

    Component.onCompleted: {
        console.log(component.width, component.height);
    }
}