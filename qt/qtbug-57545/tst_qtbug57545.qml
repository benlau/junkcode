import QtQuick 2.3
import QtTest 1.0

TestCase {
    name: "QTBUG-57545"

    function test_condition1() {
         var array = [2,3,1];
         array.shift();
         array.sort();
         compare(array, [1,3]);
    }

    function test_condition2() {
         var array = [2,1,3];
         array.shift();
         array.sort();
         compare(array, [1,3]);
    }
}
