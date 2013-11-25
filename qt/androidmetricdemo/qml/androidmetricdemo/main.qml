/* Author: Ben Lau (https://github.com/benlau) */
import QtQuick 2.0
import "android.js" as Android

Rectangle {
    width: 400
    height: 400

    Text {
        text: "The density is " + Android.density()
        anchors.centerIn: parent
        font.pixelSize : Android.pixel(18);
    }

    MouseArea {
        id: mouseArea1
        anchors.bottomMargin: 0
        anchors.top: actionBar.bottom
        anchors.right: parent.right
        anchors.bottom: navBar.top
        anchors.left: parent.left
        anchors.topMargin: 0
        onClicked: {
            Qt.quit();
        }
    }

    Rectangle {
        id: actionBar
        height: Android.pixel(48)
        color: "#3498db"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        Text {
            id: text1
            x: 144
            y: 17
            color: "#ffffff"
            text: "Action Bar - 48DP"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize : Android.pixel(22);
        }
    }

    Rectangle {
        id: navBar
        x: 0
        y: 360
        height: Android.pixel(48)
        color: "#3498db"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
    }
}
