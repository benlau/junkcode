import QtQuick 2.0

Rectangle {
    id: line

    property point p1: Qt.point(0,0)
    property point p2: Qt.point(0,0)

    property real lineWidth: 1

    transformOrigin: Item.Left

    onP1Changed: {
        refresh();
    }

    onP2Changed: {
        refresh();
    }

    function _length(p1,p2) {
        return Math.sqrt(Math.pow(p1.x - p2.x,2) + Math.pow(p1.y - p2.y, 2))
    }

    function refresh() {
        line.height = lineWidth;
        line.width = _length(p1,p2);
        line.x = p1.x;
        line.y = p1.y - lineWidth / 2; // Transform Origin at Left
        line.rotation = Math.atan2(p2.y - p1.y, p2.x - p1.x) * 180 / Math.PI
    }

    Component.onCompleted: {
        refresh();
    }
}
