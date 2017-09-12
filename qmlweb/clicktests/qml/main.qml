import QtQuick 2.0

Item {
    id: component
    
    Rectangle {
    id: bg
        width: parent.width
        height: 400
        color: "red"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            console.log("clicked");
        }
        
        onPressed: {
            console.log("pressed");
        }
        
        onReleased: {
            console.log("released");
        }
        
        onPressedChanged: console.log("changed");
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