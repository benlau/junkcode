import QtQuick 2.6
import QtQuick.Window 2.2
import QuickPromise 1.0 // It muse use QuickPromise v1.0.7

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    function grabImage(item) {
        return Q.promise(function(resolve) {
            item.grabToImage(function (result) {
                resolve(result);
            });
        });
    }

    /// Just demonstrate how to use a chain. "a" / "b" is something meaningless
    function grabImage2(item, a, b) {
        return grabImage(item).then(function(result) {
            imageViewer.source = result.url;

            return Q.promise(function(resolve) {
                return resolve([a, b]);
            });
        });
    }

    Row {
        Rectangle {
            id: source
            width: 320
            height: 240
            color: "red"
        }

        Image {
            id: imageViewer
            width: 320
            height: 240
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
//            grabImage(source).then(function(result) {
//                imageViewer.source = result.url;
//            });
            grabImage2(source , 3,4).then(function(result) {
                console.log(result);   //qml: [3,4]
            });
        }
    }
}
