var fs = require('fs');
var shell = require('shelljs');
const path = require('path');

// Default rule
var defaultRule = {
    ignorePattern: [],
    pathReplace: [
        {
            find: "",
            replace: ""
        }
    ],
    fileReplace: [
        {
            "pattern": ".*",
            "find": "\\\\",
            "replace": "\\\\"
        }
    ]
}

function run(output) {
    var ruleFilePath = path.resolve(output, "rule.json");

    if (!shell.test("-e", ruleFilePath)) {
        shell.ShellString(JSON.stringify(defaultRule,null,4)).to(ruleFilePath);
        console.log("rule.json created");
    }    
}

run(shell.pwd().toString());
