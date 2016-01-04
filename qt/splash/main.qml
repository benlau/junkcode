import QtQuick 2.2
import QtQuick.Window 2.2

Window {
    id: window;
    width: 480
    height: 640

    color: "#FFFFFF"

    visible: true

    ListView {
        anchors.fill: parent
        model: 100
        delegate: Item {
            height: 200;
            width: window.width
            Text {
                text: modelData;
            }
        }
    }
}
