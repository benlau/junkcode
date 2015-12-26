import QtQuick 2.0
import QtQuick.Window 2.0
import QuickAndroid 0.1

Window {
    width: 480
    height: 640
    visible: true

    PageStack {
        id: stack;
        anchors.fill: parent
        initialPage: Page {
            id: dummy
        }
    }

    Component.onCompleted: {
        timer.start();
    }

    Timer {
        id: timer
        interval: 300
        repeat: true
        onTriggered:  {
            if (stack.count > 1) {
                stack.pop();
            } else {
                stack.push(Qt.resolvedUrl("./Page1.qml"));
            }
        }
    }
}

