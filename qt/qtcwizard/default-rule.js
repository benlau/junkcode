module.exports = {
    /// The files to be ignored
    ignoreFilePattern: ["\\.swp$", "\\.DS_Store$"],
    filePath: [ 
        {
            find: "", 
            replace: ""
        }
    ],
    fileContent: [
        {
            "pattern": ".*", // Apply the changes to file matched
            "find": "\\", // RegExp - Find every "\"
            "replace": "\\" // Replace by 
        }
    ]
}