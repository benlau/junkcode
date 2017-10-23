import QtQuick 2.3
import QtQuick.Window 2.2
import QtMultimedia 5.5
import QtQuick.Controls 1.4
import ChatRoom.constants 1.0
import ChatRoom.actions 1.0
import ChatRoom.stores 1.0
import ChatRoom.middlewares 1.0
import QuickFlux 1.1
import QtQuick.Layouts 1.3

Window {
    id: mainWindow
    visible: false
    width: 480
    height: 640

    MiddlewareList {
        applyTarget: AppDispatcher

        SystemMiddleware {
            mainWindow: mainWindow
        }

        NetworkSimulationMiddleware {

        }
    }

    ColumnLayout {
        anchors.fill: parent

        ListView {
            model: MainStore.chatMessage
            Layout.fillHeight: true
            Layout.fillWidth: true

            delegate: Item {
                width: parent.width
                height: 40

                Text {
                    font.pixelSize: 24
                    text: model.index
                }
            }
        }

        Row {
            Layout.fillHeight: false
            Layout.fillWidth: true

            Button {
                text: "prev"
                onClicked: AppActions.loadChatMessage("elder");
            }

            Button {
                text: "next"
                onClicked: AppActions.loadChatMessage("newer");
            }
        }

    }

    Component.onCompleted: {
        AppActions.loadChatMessage();
    }

}
