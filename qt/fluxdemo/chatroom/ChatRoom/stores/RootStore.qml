import QtQuick 2.0
import QuickFlux 1.1
import "../actions"

Store {
    property string text : "Hello World!"

    property PagingListModel chatMessage:  PagingListModel {
        id: chatMessage
        pageSize: 20
    }

    Filter {
        type: ActionTypes.loadChatMessages
        onDispatched: {
            chatMessage.update(message);
        }
    }

}
