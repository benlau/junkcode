

function load() {
    var status = Qt.include("./source.js");

    if (status.status !== 0) {
        console.warn(status.exception.lineNumber + ":" + status.exception);
    }

    return status.status;
}
