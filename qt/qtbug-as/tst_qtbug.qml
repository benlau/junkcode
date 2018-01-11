import QtQuick 2.3
import QtTest 1.0
import "./wrapper.js" as Wrapper

TestCase {
    name: "qtbug"

    function test_load() {
        compare(Wrapper.load(), 0);
    }
}
