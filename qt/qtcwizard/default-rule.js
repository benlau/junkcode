module.exports = {
    /// The files to be ignored
    ignorePattern: ["\.swp$"],
    pathReplace: [ 
        {
            find: "", 
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