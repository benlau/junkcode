import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Text {
        text: "A"
        anchors.centerIn: parent
        font.pixelSize: 28
        RotationAnimation on rotation {
            loops: Animation.Infinite
            from: 0
            to: 360
            duration: 1000
        }
    }

    DropArea {
        anchors.fill: parent

        onEntered: {
            drag.accept (Qt.CopyAction);
        }

        onDropped: {
            var urls = [];
            for (var i = 0 ; i < drop.urls.length; i++) {
                var url = drop.urls[i];
                console.log(url);
            }
            drop.accept(Qt.CopyAction);
        }
    }

}
