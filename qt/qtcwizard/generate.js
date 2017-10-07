var fs = require('fs');
var shell = require('shelljs');
const path = require('path');
var rule = require("./default-rule.js");

function run(input, output) {

    var ruleFile = input + "/rule.json";

    if (!shell.test("-f", ruleFile ) ){
        console.log("rule.json not found. Please run `qtcwizard init` to create default rule.json");
        return -1;
    }

    rule = JSON.parse(shell.cat(ruleFile));
    
    var defaultIgnorePattern = ["rule.json"];
    rule.ignorePattern = rule.ignorePattern ? rule.ignorePattern.concat(defaultIgnorePattern) : defaultIgnorePattern
    
    if (!shell.test("-f", input + "/wizard.json")) {
        console.log("wizard.json not found. Please run `qtcwizard init` to create default rule.json");
        return -1;        
    }

    var files = shell.find(input).filter(function(file) {
        var name = path.basename(file);
        return !shell.test("-d", file) && name.toLocaleLowerCase !== "rule.json" 
    });

    var generators = [];
    var basePath = path.resolve(input) + "/";

    var files = files.filter(function(file){

        var source = file.replace(basePath, "");

        return rule.ignorePattern.reduce(function(acc, value) {
            var res = source.match(value);
            if (res) {
                acc.include = false;
            }
            return acc;
        }, { include: true} ).include;
        
    }).map(function(file) {

        var source = file.replace(basePath, "");

        var target = rule.pathReplace.reduce(function(acc, value) {
            return acc.replace(new RegExp(value.find, "g"), value.replace);
        }, source);

        var content = shell.cat(file);

        var newContent = rule.fileReplace.reduce(function(acc,value) {
            return acc.replace(new RegExp(value.find, "g"), value.replace);
        }, content);

        var outputFile = path.resolve(output, source);

        var dirname = path.dirname(outputFile);

        shell.mkdir("-p", dirname);

        shell.ShellString(newContent).to(outputFile);

        var res = {
            source: source,
            target: target
        }

        if (source.match(/pro$/)) {
            res.openAsProject = true;
        }

        return res;
    });

    var wizardFilePath = path.resolve(output, "wizard.json");
    var content = shell.cat(wizardFilePath);
    var wizard = JSON.parse(content);

    wizard.generators = [
        {
            typeId: "File",
            "data": files
        }
    ];

    shell.ShellString(JSON.stringify(wizard,null,4)).to(wizardFilePath);
   
}

module.exports = run