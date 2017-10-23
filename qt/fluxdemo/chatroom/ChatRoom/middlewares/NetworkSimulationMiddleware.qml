import QtQuick 2.0
import QuickFlux 1.1
import QuickPromise 1.0
import "../actions"
import "../stores"

Middleware {

    function request(pageNum, pageSize) {
        // Just simulate a network request
        Q.setTimeout(function() {
            var content = [];
            for (var i = 0 ; i < pageSize; i++) {
                var item = {
                    index: pageNum * pageSize + i
                }
                content.push(item);
            }
            var payload = {
                content: content,
                pageNum: pageNum
            }
            next(ActionTypes.loadChatMessages, {pagedPayload: payload});
        }, 1000);
    }

    function loadChatMessages(message) {
        if (message.hasOwnProperty("ops")) {
            var ops = message.ops;
            if (ops === "newer") {
                request(MainStore.chatMessage.endPageNum + 1, MainStore.chatMessage.pageSize);
            } else if (ops === "elder") {
                request(MainStore.chatMessage.startPageNum - 1, MainStore.chatMessage.pageSize);
            }

        } else if (message.hasOwnProperty("pageNum")) {
            request(message.pageNum, MainStore.chatMessage.pageSize);
        }
    }

    function dispatch(type, message) {

        switch (type) {
        case ActionTypes.loadChatMessages:
            loadChatMessages(message);
            break;
        default:
            next(type, message);
            break;
        }
    }

}
