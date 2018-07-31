import QtQuick 2.7

Item {
    width: 640
    height: 480

    Rectangle {
        color: "blue"
        x: 100
        y:  100
        width: 100
        height: 100
        opacity: 0.3
        visible: false
    }

    Line {
        p1: Qt.point(100,100);
        p2: Qt.point(200,200);
        lineWidth: 1
        color: "red"
    }

    Line {
        p1: Qt.point(100,100);
        p2: Qt.point(0,0);
        lineWidth: 1
        color: "red"
    }

    Line {
        p1: Qt.point(100,100);
        p2: Qt.point(100,-100);
        lineWidth: 1
        color: "red"
    }

    Line {
        p1: Qt.point(100,100);
        p2: Qt.point(100,200);
        lineWidth: 1
        color: "red"
    }
}
