import QtQuick 2.0

ListModel {
    id: listModel

    property int startPageNum: -1
    property int endPageNum: -1
    property int pageSize: 0

    /// Copy a JavaScript array to model
    function copyToModel(model, offset, list) {
        if (!list) {
            model.clear();
            return;
        }

        for (var i in list) {
            var item = list[i];
            var pos = offset + i;
            if (model.count > pos) {
                model.set(pos, item);
            } else {
                model.append(item);
            }
        }
    }

    function clear() {
        pageSize = 0;
        startPageNum = -1;
    }

    function update(message) {
        var payload = message.pagedPayload;

        var pageNum = payload.pageNum;
        var content = payload.content;

        if (startPageNum < 0) {
            startPageNum = pageNum;
            endPageNum = pageNum;
            copyToModel(listModel, 0, content);
        } else if (pageNum === startPageNum - 1) {
            for (var i in content) {
                insert(i, content[i]);
            }
            startPageNum = pageNum;
        } else if (endPageNum + 1 === pageNum) {
            for (var i in content) {
                console.log(JSON.stringify(content[i]))
                listModel.append(content[i]);
            }
            endPageNum = pageNum;
        } else {
            // if the pageNum within the range
            // update by using copyToModel
        }
    }

}
