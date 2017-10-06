module.exports = {
    ignorePattern: [],
    pathReplace: [ 
        {
            find: "", // Pattern of match
            replace: ""
        }
    ],
    fileReplace: [
        {
            "pattern": ".*", // Apply the changes to file matched
            "find": "\\\\", // Pattern of text
            "replace": "\\\\" // Replace the found text
        }
    ]
}