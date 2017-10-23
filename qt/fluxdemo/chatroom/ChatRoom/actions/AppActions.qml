pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0
import "."

ActionCreator {

    signal startApp

    signal quitApp

    function loadChatMessage() {
        var msg = {};

        if (arguments.length >= 1) {
            var arg = arguments[0];
            if (typeof arg === "string") {
                msg.ops = arg;
            } else {
                msg.pageNum = arg;
            }
        } else {
            msg.pageNum = 0;
        }

        dispatch(ActionTypes.loadChatMessages, msg)
    }
}
