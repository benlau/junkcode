var fs = require('fs');
var shell = require('shelljs');
const path = require('path');
var defaultWizardJson = require("./default-wizard.js");

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
    
    var wizardFilePath = path.resolve(output, "wizard.json");
    
    if (!shell.test("-e", wizardFilePath)) {
        shell.ShellString(JSON.stringify(defaultWizardJson,null,4)).to(wizardFilePath);
        console.log("wizard.json created");
    }
    
}

module.exports = run;